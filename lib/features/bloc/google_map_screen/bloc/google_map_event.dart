part of 'google_map_bloc.dart';

sealed class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();

  @override
  List<Object> get props => [];
}

final class GoogleMapStarted extends GoogleMapEvent {}

final class GoogleMapReload extends GoogleMapEvent {}
