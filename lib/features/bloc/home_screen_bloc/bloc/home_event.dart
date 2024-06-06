part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeStarted extends HomeEvent {
  final String userId;

  const HomeStarted({required this.userId});
  @override
  List<Object> get props => [userId];
}

final class HomeRefresh extends HomeEvent {
  final String userId;

  const HomeRefresh({required this.userId});
  @override
  List<Object> get props => [userId];
}
