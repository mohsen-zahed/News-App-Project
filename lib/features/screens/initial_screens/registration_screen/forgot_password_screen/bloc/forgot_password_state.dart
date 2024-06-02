part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSentSuccess extends ForgotPasswordState {}

final class ForgotPasswordSentFailed extends ForgotPasswordState {
  final String errorMessage;

  const ForgotPasswordSentFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
