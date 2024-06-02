part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpButtonIsClicked extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  const SignUpButtonIsClicked({required this.name, required this.email, required this.password});
  @override
  List<Object> get props => [name, email, password];
}
