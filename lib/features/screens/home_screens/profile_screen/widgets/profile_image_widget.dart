import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.userImage,
    required this.onTap,
    required this.onCameraTap,
  });

  final GestureTapCallback onTap;
  final String userImage;
  final GestureTapCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getScreenArea(context, 0.0005),
        height: getScreenArea(context, 0.0005),
        padding: EdgeInsets.all(getScreenArea(context, 0.000005)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: kSecondaryColor,
            width: 3,
          ),
        ),
        child: CustomCachedNetworkImage(borderRadius: 100, imageUrl: userImage),
      ),
    );
  }
}
