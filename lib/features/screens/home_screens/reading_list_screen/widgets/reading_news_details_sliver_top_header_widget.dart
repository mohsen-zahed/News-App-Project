import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/full_screen_image.dart';

class ReadingNewsDetailsSliverTopHeaderWidget extends SliverPersistentHeaderDelegate {
  final Map<String, dynamic> newsListModel;

  @override
  final double maxExtent;
  @override
  final double minExtent;

  const ReadingNewsDetailsSliverTopHeaderWidget({
    required this.newsListModel,
    required this.maxExtent,
    required this.minExtent,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FullScreenImage(imageUrl: newsListModel['imageUrl'])));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          //* Top news image box...
          CustomCachedNetworkImage(borderRadius: 10, imageUrl: newsListModel['imageUrl']),
          //* Slight dark shadow on image...
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
          //* Two vertical texts... title with author and publishedAt
          Positioned(
            left: getMediaQueryWidth(context, 0.035),
            right: getMediaQueryWidth(context, 0.035),
            bottom: getMediaQueryHeight(context, 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* Title text...
                Text(
                  '${newsListModel['title']}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                //* Author and publishedAt texts...
                Text(
                  '${newsListModel['author']} • ${newsListModel['publishedAt']}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kGreyColor),
                  maxLines: 1,
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
