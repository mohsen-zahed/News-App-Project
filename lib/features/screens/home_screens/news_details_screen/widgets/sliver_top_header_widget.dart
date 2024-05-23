import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/screens/home_screens/news_details_screen/widgets/full_screen_image.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:news_app_project/widgets/custom_cached_network_image.dart';

class TopHeaderWidget extends SliverPersistentHeaderDelegate {
  final GeneralNewsModel generalNewsModel;

  @override
  final double maxExtent;
  @override
  final double minExtent;

  const TopHeaderWidget({
    required this.generalNewsModel,
    required this.maxExtent,
    required this.minExtent,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: generalNewsModel.imageUrl)));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomCachedNetworkImage(borderRadius: 10, imageUrl: generalNewsModel.imageUrl),
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
                  child: Text(generalNewsModel.title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor)),
                ),
                const SizedBox(height: 10),
                Text(
                  '${generalNewsModel.author} • ${generalNewsModel.publishedAt}',
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
