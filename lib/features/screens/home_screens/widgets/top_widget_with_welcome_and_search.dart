import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/utils/my_media_query.dart';

class TopWidgetWithWelcomeAndSearch extends StatelessWidget {
  final String welcomeText;
  final GestureCancelCallback onSearchTap;
  final GestureCancelCallback onNotificationTap;
  const TopWidgetWithWelcomeAndSearch({
    super.key,
    required this.welcomeText,
    required this.onSearchTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context),
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, 0.04),
        vertical: getmediaQueryHeight(context, 0.02),
      ),
      child: Row(
        children: [
          Text(
            welcomeText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kGreyColorShade200,
              ),
              child: const Icon(CupertinoIcons.search),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kGreyColorShade200,
              ),
              child: const Icon(CupertinoIcons.bell),
            ),
          ),
        ],
      ),
    );
  }
}
