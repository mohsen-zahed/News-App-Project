part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileScreenLoading extends ProfileState {}

final class ProfileScreenSuccess extends ProfileState {
  final dynamic userInfo;

  const ProfileScreenSuccess({required this.userInfo});
}

final class ProfileScreenFailed extends ProfileState {
  final String errorMessage;

  const ProfileScreenFailed({required this.errorMessage});
}

//** */

final class ProfileChangeImageLoading extends ProfileState {}

final class ProfileChangeImageSucess extends ProfileState {
  final String imageUrl;

  const ProfileChangeImageSucess({required this.imageUrl});
}

final class ProfileChangeImageFailed extends ProfileState {
  final String previousImageUrl;

  const ProfileChangeImageFailed({required this.previousImageUrl});
}
