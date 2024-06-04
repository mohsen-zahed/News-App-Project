import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final IFirebaseUserInfoRepository iFirebaseAuthRepository;
  SignUpBloc(this.iFirebaseAuthRepository) : super(SignUpLoading()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpButtonIsClicked) {
        emit(SignUpLoading());
        try {
          final userCredential = await iFirebaseAuthRepository.signUpWithEmailAndPassword(event.name, event.email, event.password);

          final documentSnapshot = await iFirebaseAuthRepository.getUserInfoFromFirebase(userCredential.user!.uid);
          final user = await iFirebaseAuthRepository.getCurrentUser(userCredential);
          emit(SignUpSuccess(userCredential, user, documentSnapshot));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(const SignUpFailed(errorMessage: 'Enter a strong password!'));
          } else if (e.code == 'email-already-in-use') {
            emit(const SignUpFailed(errorMessage: 'This email address is already in use!'));
          } else if (e.code == 'invalid-email') {
            emit(const SignUpFailed(errorMessage: 'Invalid email address, double check and try again!'));
          } else if (e.code == 'operation-not-allowed') {
            emit(const SignUpFailed(errorMessage: 'Sorry, but sign up is not allowed at this time!'));
          } else if (e.code == 'user-disabled') {
            emit(const SignUpFailed(errorMessage: 'User disabled!'));
          } else if (e.code == 'user-not-found') {
            emit(const SignUpFailed(errorMessage: 'No user found with this email address!'));
          } else if (e.code == 'wrong-password') {
            emit(const SignUpFailed(errorMessage: 'Password is wrong, double check and try again!'));
          } else {
            emit(SignUpFailed(errorMessage: e.message!));
          }
        }
      }
    });
  }
}
