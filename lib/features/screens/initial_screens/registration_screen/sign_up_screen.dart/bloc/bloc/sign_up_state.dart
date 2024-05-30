part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserCredential userCredential;

  const SignUpSuccess({required this.userCredential});
}

final class SignUpFailed extends SignUpState {
  final String errorMessage;

  const SignUpFailed({required this.errorMessage});
}
