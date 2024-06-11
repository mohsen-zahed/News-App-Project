part of 'google_map_bloc.dart';

sealed class GoogleMapState extends Equatable {
  const GoogleMapState();

  @override
  List<Object> get props => [];
}

final class GoogleMapLoading extends GoogleMapState {}

final class GoogleMapSuccess extends GoogleMapState {
  final Position position;

  const GoogleMapSuccess({required this.position});
  @override
  List<Object> get props => [position];
}

final class GoogleMapFailed extends GoogleMapState {
  final String errorMessage;

  const GoogleMapFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
