import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class HaveOrDontHaveAccountAndForgotPassTexts extends StatefulWidget {
  final void Function() onAccountTextsTap;
  final GestureTapCallback onRightTextTap;
  final String text;
  final String text2;
  final bool isLoginScreen;
  const HaveOrDontHaveAccountAndForgotPassTexts({
    super.key,
    required this.onRightTextTap,
    required this.isLoginScreen,
    required this.text,
    required this.text2,
    required this.onAccountTextsTap,
  });

  @override
  State<HaveOrDontHaveAccountAndForgotPassTexts> createState() => _HaveOrDontHaveAccountAndForgotPassTextsState();
}

class _HaveOrDontHaveAccountAndForgotPassTextsState extends State<HaveOrDontHaveAccountAndForgotPassTexts> {
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
                text: "${widget.text} ",
                children: [
                  TextSpan(
                    text: widget.text2,
                    style: const TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = widget.onAccountTextsTap,
                  ),
                ],
              ),
            ),
          ),
          widget.isLoginScreen
              ? SizedBox(
                  child: GestureDetector(
                    onTap: widget.onRightTextTap,
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: kGreyColorShade400,
                            decoration: TextDecoration.underline,
                            decorationColor: kGreyColorShade400,
                          ),
                    ),
                  ),
                )
              : SizedBox(
                  child: GestureDetector(
                    onTap: widget.onRightTextTap,
                    child: Text(
                      'Reset form',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
