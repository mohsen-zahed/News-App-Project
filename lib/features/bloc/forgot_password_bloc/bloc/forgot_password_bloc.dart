import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IFirebaseUserInfoRepository iFirebaseAuthRepository;
  ForgotPasswordBloc(this.iFirebaseAuthRepository) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      if (event is ForgotPasswordButtonIsClicked) {
        emit(ForgotPasswordLoading());
        try {
          await iFirebaseAuthRepository.sendForgotPasswordLink(event.email);
          emit(ForgotPasswordSentSuccess(email: event.email));
        } on FirebaseException catch (e) {
          emit(ForgotPasswordSentFailed(errorMessage: e.message!));
        }
      }
    });
  }
}
