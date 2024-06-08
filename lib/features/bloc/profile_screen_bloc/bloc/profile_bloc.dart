import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IFirebaseUserInfoRepository iFirebaseAuthRepository;
  ProfileBloc(this.iFirebaseAuthRepository) : super(ProfileScreenLoading()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileScreenStarted || event is ProfileScreenRefresh || event is ProfileImageChangeIsClicked) {
        emit(ProfileScreenLoading());
        String userId = '';
        if (event is ProfileScreenStarted) {
          userId = event.userId;
        } else if (event is ProfileScreenRefresh) {
          userId = event.userId;
        }
        try {
          if (event is ProfileImageChangeIsClicked) {
            try {
              emit(ProfileChangeImageLoading());
              final image = await iFirebaseAuthRepository.updateUserImage(event.previousImageUrl, userId);
              emit(ProfileChangeImageSucess(imageUrl: image));
            } catch (e) {
              emit(ProfileChangeImageFailed(previousImageUrl: event.previousImageUrl));
            }
          }
          final userInfo = await iFirebaseAuthRepository.getUserInfoFromFirebase(userId);
          emit(ProfileScreenSuccess(userInfo: userInfo));
        } on FirebaseException catch (e) {
          emit(ProfileScreenFailed(
            errorMessage: e.message.toString(),
          ));
        }
      } else if (event is SignOutButtonIsClicked) {
        try {
          emit(ProfileSignOutLoading());
          await iFirebaseAuthRepository.signOutUser();
          emit(ProfileSignOutSuccess());
        } on FirebaseAuthException catch (e) {
          emit(ProfileSignOutFailed(
            errorMessage: e.message.toString(),
          ));
        }
      }
    });
  }
}
