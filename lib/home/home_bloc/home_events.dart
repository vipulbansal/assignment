import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';

abstract class HomeEvent extends Equatable {}

class GetUsersEvent extends HomeEvent {
  final BuildContext buildContext;

  GetUsersEvent(this.buildContext);

  @override
  List<Object?> get props => [buildContext];
}

class SearchUsersEvent extends HomeEvent {
  final String searchString;

  SearchUsersEvent(this.searchString);

  @override
  List<Object?> get props => [searchString];
}

class SetFavouriteEvent extends HomeEvent {
  final UserModel userModel;
  bool isShowingFavourites;

  SetFavouriteEvent(
    this.userModel,
    this.isShowingFavourites,
  );

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class ShowFavouritesEvent extends HomeEvent {
  final bool favouriteToggle;

  ShowFavouritesEvent(this.favouriteToggle);

  @override
  List<Object?> get props => [favouriteToggle];
}
