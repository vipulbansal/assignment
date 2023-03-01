import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:vipul_assignment/home/home_bloc/home_events.dart';
import 'package:vipul_assignment/home/home_bloc/home_states.dart';
import 'package:vipul_assignment/models/user_model.dart';
import 'package:vipul_assignment/utils/constants.dart';
import 'package:vipul_assignment/utils/shared_preferences.dart';
import 'package:collection/collection.dart';

import '../../repository/api_provider.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiProvider apiProvider = ApiProvider();
  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];

  HomeBloc(super.initialState) {
    on<GetUsersEvent>((event, emit) async {
      bool network = await hasNetwork();
      if (!network) {
        emit(NoNetworkState());
        return;
      }
      emit(Loading());
      if (!event.buildContext.mounted) {
        emit(GenericErrorState("Error in fetching data"));
      } else {
        final response = await apiProvider.fetchUsers(event.buildContext);
        if (response is List<UserModel>) {
          String jsonUsers =
              await MySharedPreferences.getString(Constants.FAVOURITES);
          List<UserModel> favUsers =
              jsonUsers.isEmpty ? [] : userModelFromJson(jsonUsers);
          users = response;
          if (favUsers.isNotEmpty) {
            for (UserModel userModel in users) {
              UserModel? u = favUsers
                  .firstWhereOrNull((element) => element.id == userModel.id);
              if (u != null) {
                userModel.isFavourite = true;
              }
            }
          }
          filteredUsers = List.from(users);
          emit(UserDataLoadedState());
        } else {
          emit(UserDataLoadedErrorState(response));
        }
      }
    });

    on<SearchUsersEvent>((event, emit) {
      if (event.searchString.isNotEmpty) {
        filteredUsers.clear();
        users.forEach((element) {
          if (element.name
                  ?.toLowerCase()
                  .contains(event.searchString.toLowerCase()) ??
              false) {
            filteredUsers.add(element);
          }
        });
      } else {
        filteredUsers = List.from(users);
      }
      emit(UserDataSearchedState());
      emit(UserDataLoadedState());
    });

    on<SetFavouriteEvent>((event, emit) async {
      String jsonUsers =
          await MySharedPreferences.getString(Constants.FAVOURITES);
      List<UserModel> favUsers =
          jsonUsers.isEmpty ? [] : userModelFromJson(jsonUsers);
      if (event.userModel.isFavourite) {
        event.userModel.isFavourite = false;
        favUsers.removeWhere((element) => element.id == event.userModel.id);
        if (event.isShowingFavourites) {
          filteredUsers
              .removeWhere((element) => element.id == event.userModel.id);
        }
      } else {
        event.userModel.isFavourite = true;
        favUsers.add(event.userModel);
      }
      UserModel uModel =
          users.firstWhere((element) => element.id == event.userModel.id);
      uModel.isFavourite = event.userModel.isFavourite;
      await MySharedPreferences.setString(
          Constants.FAVOURITES, userModelToJson(favUsers));
      emit(UserDataSearchedState());
      emit(UserDataLoadedState());
    });

    on<ShowFavouritesEvent>((event, emit) async {
      if (event.favouriteToggle) {
        String jsonUsers =
            await MySharedPreferences.getString(Constants.FAVOURITES);
        List<UserModel> favUsers =
            jsonUsers.isEmpty ? [] : userModelFromJson(jsonUsers);
        filteredUsers = List.from(favUsers);
      } else {
        filteredUsers = List.from(users);
      }
      emit(UserDataSearchedState());
      emit(UserDataLoadedState());
    });
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
