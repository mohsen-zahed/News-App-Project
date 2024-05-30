import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final IFirebaseAuthRepository iFirebaseAuthRepository;
  SignUpBloc(this.iFirebaseAuthRepository) : super(SignUpLoading()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpButtonIsClicked) {
        emit(SignUpLoading());
        try {
          final userCredential = await iFirebaseAuthRepository.signUpWithEmailAndPassword(event.email, event.password);
          emit(SignUpSuccess(userCredential: userCredential));
        } on FirebaseAuthException catch (e) {
          emit(SignUpFailed(errorMessage: e.message!));
        }
      }
    });
  }
}
