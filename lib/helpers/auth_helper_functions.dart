import 'package:news_app/config/constants/lists.dart';

class AuthHelperFunctions {
  static AuthHelperFunctions? _authHelperFunctions;
  AuthHelperFunctions._();
  static AuthHelperFunctions get instance {
    _authHelperFunctions ??= AuthHelperFunctions._();
    return _authHelperFunctions!;
  }

  Future validateEmailAndPassword(String email, String password, String confirmPassword) async {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      if (!emailErrorList.contains('Email field is required!')) {
        emailErrorList.add('Email field is required!');
      }
    } else {
      emailErrorList.remove('Email field is required!');
      if (!emailRegex.hasMatch(email)) {
        if (!emailErrorList.contains('Email address is badly formatted!')) {
          emailErrorList.add('Email address is badly formatted!');
        }
      } else {
        emailErrorList.remove('Email address is badly formatted!');
      }
    }
    if (password == confirmPassword) {
      if (password.isEmpty) {
        if (!passwordErrorList.contains('Password field is required!')) {
          passwordErrorList.add('Password field is required!');
        }
      } else {
        passwordErrorList.remove('Password field is required!');
        if (password.length < 6) {
          if (!passwordErrorList.contains('Password must be more than 6 characters!')) {
            passwordErrorList.add('Password must be more than 6 characters!');
          }
        } else if (password.length == 6 || password.length > 6) {
          if (passwordErrorList.contains('Password must be more than 6 characters!')) {
            passwordErrorList.add('Password must be more than 6 characters!');
          }
        }
      }
    } else {
      if (!passwordErrorList.contains('Password and Confirm password should be the same!')) {
        passwordErrorList.add('Password and Confirm password should be the same!');
      } else if (passwordErrorList.contains('Password and Confirm password should be the same!')) {
        passwordErrorList.remove('Password and Confirm password should be the same!');
      }
    }
  }
}
