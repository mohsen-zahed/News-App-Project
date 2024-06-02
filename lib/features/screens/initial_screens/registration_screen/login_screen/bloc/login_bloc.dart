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
          emit(LoginFailed(errorMessage: e.message!));
        }
      }
    });
  }
}
