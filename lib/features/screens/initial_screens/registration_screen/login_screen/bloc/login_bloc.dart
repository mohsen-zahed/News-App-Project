import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IFirebaseAuthRepository iFirebaseAuthRepository;
  LoginBloc(this.iFirebaseAuthRepository) : super(LoginLoading()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonIsClicked) {
        emit(LoginLoading());
        try {
          final userCredential = await iFirebaseAuthRepository.loginWithEmailAndPassword(event.email, event.password);
          emit(LoginSuccess(userCredential));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            emit(LoginFailed(errorMessage: 'Email address is not valid!'.toString()));
          } else if (e.code == 'user-disabled') {
            emit(LoginFailed(errorMessage: 'This user is no longer activated!'.toString()));
          } else if (e.code == 'user-not-found') {
            emit(LoginFailed(errorMessage: 'No user with this email was found!'.toString()));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailed(errorMessage: 'Wrong password!'.toString()));
          } else {
            emit(LoginFailed(errorMessage: e.code.toString()));
          }
        }
      }
    });
  }
}
