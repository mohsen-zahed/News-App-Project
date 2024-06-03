import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IFirebaseAuthRepository iFirebaseAuthRepository;
  ForgotPasswordBloc(this.iFirebaseAuthRepository) : super(ForgotPasswordLoading()) {
    on<ForgotPasswordEvent>((event, emit) {
      if (event is ForgotPasswordButtonIsClicked) {
        emit(ForgotPasswordLoading());
        try {
          iFirebaseAuthRepository.sendForgotPasswordLink(event.email);
          emit(ForgotPasswordSentSuccess());
        } on FirebaseException catch (e) {
          emit(ForgotPasswordSentFailed(errorMessage: e.message!));
        }
      }
    });
  }
}
