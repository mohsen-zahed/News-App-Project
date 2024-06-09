part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserCredential userCredential;
  final User? user;
  final dynamic documentSnapshot;

  const SignUpSuccess(this.userCredential, this.user, this.documentSnapshot);
}

final class SignUpFailed extends SignUpState {
  final String errorMessage;

  const SignUpFailed({required this.errorMessage});
}

final class SignUpError extends SignUpState {
  final List<String> emailErrorList;
  final List<String> passwordErrorList;

  const SignUpError({required this.emailErrorList, required this.passwordErrorList});
}
