import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class DontHaveAccountAndForgotPasswordTexts extends StatelessWidget {
  final TapGestureRecognizer onSignUpTap;
  final GestureTapCallback onForgotPassTap;
  const DontHaveAccountAndForgotPasswordTexts({
    super.key,
    required this.onSignUpTap,
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
                    decoration: TextDecoration.underline,
                    decorationColor: kGreyColorShade400,
                  ),
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: "SignUp",
                    recognizer: onSignUpTap,
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
