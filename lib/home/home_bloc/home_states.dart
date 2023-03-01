import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class UserDataLoadedState extends HomeState {
  UserDataLoadedState();

  @override
  List<Object?> get props => [];
}

class UserDataLoadedErrorState extends HomeState {
  final String errorMessage;

  UserDataLoadedErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class Loading extends HomeState {
  Loading();

  @override
  List<Object?> get props => [];
}

class NoNetworkState extends HomeState {
  NoNetworkState();

  @override
  List<Object?> get props => [];
}

class GenericErrorState extends HomeState {
  final String errorMessage;

  GenericErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class UserDataSearchedState extends HomeState {
  @override
  List<Object?> get props => [];

  UserDataSearchedState();
}
