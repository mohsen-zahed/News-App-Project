import 'package:flutter/material.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/utils/my_media_query.dart';

class TryAgainWidget extends StatelessWidget {
  final Function() onTryAgainPressed;
  final String buttonText;
  final String errorMessage;
  const TryAgainWidget({
    super.key,
    required this.errorMessage,
    required this.onTryAgainPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.09)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              brokenMobilePath,
              width: getMediaQueryWidth(context, 0.8),
              height: getMediaQueryWidth(context, 0.8),
              fit: BoxFit.cover,
            ),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getMediaQueryHeight(context, 0.02)),
            ElevatedButton(
              onPressed: onTryAgainPressed,
              child: Text(
                buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
