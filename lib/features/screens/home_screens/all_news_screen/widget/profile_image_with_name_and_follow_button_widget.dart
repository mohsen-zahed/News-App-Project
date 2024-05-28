import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileImageWithNameAndFollowButtonWidget extends StatelessWidget {
  final String profileImageUrl;
  final String profileName;
  final String publishedDate;
  final GestureCancelCallback onFollowTap;
  const ProfileImageWithNameAndFollowButtonWidget({
    super.key,
    required this.profileImageUrl,
    required this.profileName,
    required this.publishedDate,
    required this.onFollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.05)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* Profile image widget...
          Container(
            width: getMediaQueryWidth(context, 0.12),
            height: getMediaQueryWidth(context, 0.12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kGreyColorShade300,
              image: DecorationImage(
                image: CachedNetworkImageProvider(profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: getMediaQueryWidth(context, 0.02)),
          //* Name and published date texts...
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profileName, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: getMediaQueryHeight(context, 0.001)),
                Text(publishedDate,
                    overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade500)),
              ],
            ),
          ),
          const Spacer(),
          //* Follow button...
          GestureDetector(
            onTap: onFollowTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: getMediaQueryWidth(context, 0.03),
                vertical: getMediaQueryHeight(context, 0.005),
              ),
              decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(50), boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: kBlackColorOp1,
                ),
              ]),
              child: Row(
                children: [
                  Text('Follow', style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: getMediaQueryWidth(context, 0.008)),
                  Icon(Icons.add, size: getMediaQueryHeight(context, 0.02)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
