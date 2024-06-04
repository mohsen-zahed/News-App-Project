part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileScreenStarted extends ProfileEvent {
  final String userId;

  const ProfileScreenStarted({required this.userId});
  @override
  List<Object> get props => [userId];
}

final class ProfileScreenRefresh extends ProfileEvent {
  final String userId;

  const ProfileScreenRefresh({required this.userId});
  @override
  List<Object> get props => [userId];
}

final class ProfileImageChangeIsClicked extends ProfileEvent {
  final String userName;
  final String userId;
  final String previousImageUrl;

  const ProfileImageChangeIsClicked({required this.userName, required this.userId, required this.previousImageUrl});
  @override
  List<Object> get props => [userName, userId, previousImageUrl];
}

final class SignOutButtonIsClicked extends ProfileEvent {}
