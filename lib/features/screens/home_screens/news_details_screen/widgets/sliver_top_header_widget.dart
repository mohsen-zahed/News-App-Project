import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/widgets/full_screen_image.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';

class SliverTopHeaderWidget extends SliverPersistentHeaderDelegate {
  final dynamic newsListModel;

  @override
  final double maxExtent;
  @override
  final double minExtent;

  const SliverTopHeaderWidget({
    required this.newsListModel,
    required this.maxExtent,
    required this.minExtent,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FullScreenImage(imageUrl: newsListModel.imageUrl)));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomCachedNetworkImage(borderRadius: 10, imageUrl: newsListModel.imageUrl),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: bannerGradientColors,
              ),
            ),
          ),
          Positioned(
            left: getMediaQueryWidth(context, 0.035),
            bottom: getMediaQueryHeight(context, 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: getMediaQueryWidth(context, 0.95)),
                  child: Text(newsListModel.title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor)),
                ),
                const SizedBox(height: 10),
                Text(
                  '${newsListModel.author} • ${newsListModel.publishedAt}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kGreyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => OverScrollHeaderStretchConfiguration();
}
