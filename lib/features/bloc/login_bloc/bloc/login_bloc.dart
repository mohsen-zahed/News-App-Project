import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IFirebaseUserInfoRepository iFirebaseAuthRepository;
  LoginBloc(this.iFirebaseAuthRepository) : super(LoginLoading()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonIsClicked) {
        emit(LoginLoading());
        try {
          final userCredential = await iFirebaseAuthRepository.loginWithEmailAndPassword(event.email, event.password);
          final documentSnapshot = await iFirebaseAuthRepository.getUserInfoFromFirebase(userCredential.user!.uid);
          final user = await iFirebaseAuthRepository.getCurrentUser(userCredential);
          emit(LoginSuccess(userCredential, user, documentSnapshot));
        } on FirebaseAuthException catch (e) {
          emit(LoginFailed(errorMessage: e.message!));
        }
      } else if (event is LoginAnonymouslyIsClicked) {
        emit(LoginAnonymouslyLoading());
        try {
          final userCredential = await iFirebaseAuthRepository.signInAnonymously();
          final documentSnapshot = await iFirebaseAuthRepository.getUserInfoFromFirebase(userCredential.user!.uid);
          final user = await iFirebaseAuthRepository.getCurrentUser(userCredential);
          emit(LoginAnonymouslySuccess(userCredential, user, documentSnapshot));
        } on FirebaseAuthException catch (e) {
          emit(LoginAnonymouslyFailed(errorMessage: e.message!));
        }
      }
    });
  }
}
