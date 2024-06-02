part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordButtonIsClicked extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordButtonIsClicked({required this.email});
  @override
  List<Object> get props => [email];
}
