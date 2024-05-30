import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/utils/my_media_query.dart';

class GoogleLoginButton extends StatelessWidget {
  final GestureTapCallback onButtonTap;
  const GoogleLoginButton({
    super.key,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getScreenArea(context, 0.000035)),
        margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.07)),
        decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(googleIconPath, height: getScreenArea(context, 0.0001)),
            SizedBox(width: getMediaQueryWidth(context, 0.025)),
            Text('SignUp with Google', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
