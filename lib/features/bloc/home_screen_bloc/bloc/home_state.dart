part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<NewsModel> newsList;

  const HomeSuccess({required this.newsList});
  @override
  List<Object> get props => [newsList];
}

final class HomeFailed extends HomeState {
  final String exception;

  const HomeFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
