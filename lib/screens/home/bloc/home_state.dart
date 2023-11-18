part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeFieldState extends HomeState {}

final class LoadingState extends HomeState {}

final class LoadedState extends HomeState {
  LoadedState(this.result);
  final bool result;
}
