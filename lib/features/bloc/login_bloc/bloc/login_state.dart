part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserCredential userCredential;

  const LoginSuccess(this.userCredential);

  @override
  List<Object> get props => [userCredential];
}

final class LoginFailed extends LoginState {
  final String errorMessage;

  const LoginFailed({required this.errorMessage});
}

final class LoginAnonymouslyLoading extends LoginState {}

final class LoginAnonymouslySuccess extends LoginState {
  final UserCredential userCredential;

  const LoginAnonymouslySuccess(this.userCredential);

  @override
  List<Object> get props => [userCredential];
}

final class LoginAnonymouslyFailed extends LoginState {
  final String errorMessage;

  const LoginAnonymouslyFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
