import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  const SubmitButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context),
      height: getScreenArea(context, 0.00017),
      margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.06)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const Center(child: CupertinoActivityIndicator(color: kWhiteColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonText, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: kWhiteColor)),
                  SizedBox(width: getMediaQueryWidth(context, 0.01)),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: getScreenArea(context, 0.00007),
                  ),
                ],
              ),
      ),
    );
  }
}
