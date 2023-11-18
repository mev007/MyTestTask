part of 'home_bloc.dart';

sealed class HomeEvent {}

class ChangeFieldEvent extends HomeEvent {
  ChangeFieldEvent(this.user);
  final UserModel user;
}

class SendUserEvent extends HomeEvent {
  SendUserEvent(this.user);
  final UserModel user;
}