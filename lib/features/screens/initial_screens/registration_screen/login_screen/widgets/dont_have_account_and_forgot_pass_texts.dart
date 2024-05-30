import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/sign_up_screen.dart/sign_up_screen.dart';
import 'package:news_app/utils/my_media_query.dart';

class DontHaveAccountAndForgotPasswordTexts extends StatelessWidget {
  final GestureTapCallback onForgotPassTap;
  const DontHaveAccountAndForgotPasswordTexts({
    super.key,
    required this.onForgotPassTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kGreyColorShade400,
                    decorationColor: kGreyColorShade400,
                  ),
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: "SignUp",
                    style: const TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: GestureDetector(
              onTap: onForgotPassTap,
              child: Text(
                'Forgot password?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kGreyColorShade400,
                      decoration: TextDecoration.underline,
                      decorationColor: kGreyColorShade400,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
