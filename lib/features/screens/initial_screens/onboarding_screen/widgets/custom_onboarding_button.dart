import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class CustomOnboardingButton extends StatelessWidget {
  const CustomOnboardingButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.controller,
  });

  final String buttonText;
  final Function() onPressed;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQueryWidth(context, 0.3),
      height: getMediaQueryHeight(context, 0.07),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_rounded,
              size: getMediaQueryWidth(context, 0.05),
            ),
          ],
        ),
      ),
    );
  }
}
