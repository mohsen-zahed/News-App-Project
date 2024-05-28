import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.5,
      margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
      decoration: BoxDecoration(
        color: kGreyColorShade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
