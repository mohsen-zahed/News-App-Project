part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSentSuccess extends ForgotPasswordState {
  final String email;

  const ForgotPasswordSentSuccess({required this.email});
  @override
  List<Object> get props => [email];
}

final class ForgotPasswordSentFailed extends ForgotPasswordState {
  final String errorMessage;

  const ForgotPasswordSentFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
