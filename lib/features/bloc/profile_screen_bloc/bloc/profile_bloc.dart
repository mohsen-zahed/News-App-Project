import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  DocumentSnapshot? userInfo;
  final IFirebaseUserInfoRepository iFirebaseAuthRepository;
  ProfileBloc(this.iFirebaseAuthRepository) : super(ProfileScreenLoading()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileScreenStarted || event is ProfileScreenRefresh) {
        emit(ProfileScreenLoading());
        String userId = '';
        if (event is ProfileScreenStarted) {
          userId = event.userId;
        } else if (event is ProfileScreenRefresh) {
          userId = event.userId;
        }
        try {
          userInfo = await iFirebaseAuthRepository.getUserInfoFromFirebase(userId);
          emit(ProfileScreenSuccess(userInfo: userInfo));
        } on FirebaseException catch (e) {
          emit(ProfileScreenFailed(
            errorMessage: e.message.toString(),
          ));
        }
      } else if (event is ProfileImageChangeIsClicked) {
        try {
          final image = await iFirebaseAuthRepository.updateUserImage(event.userName, event.userId, event.previousImageUrl);
          emit(ProfileChangeImageSucess(imageUrl: image));
          emit(ProfileScreenSuccess(userInfo: userInfo));
        } catch (e) {
          emit(ProfileChangeImageFailed(previousImageUrl: event.previousImageUrl));
        }
      } else if (event is SignOutButtonIsClicked) {
        try {
          await iFirebaseAuthRepository.signOutUser();
          emit(ProfileSignOutSuccess());
          emit(ProfileScreenSuccess(userInfo: userInfo));
        } catch (e) {
          emit(const ProfileSignOutFailed(errorMessage: 'Could not log out righ now!'));
        }
      }
    });
  }
}
