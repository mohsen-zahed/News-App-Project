part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeStarted extends HomeEvent {}

final class HomeRefresh extends HomeEvent {}