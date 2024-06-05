import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/horizontal_image_source_name_verified_badge_widget.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/sliver_top_header_widget.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';

class NewsDetailsScreen extends StatelessWidget {
  final dynamic newsList;
  const NewsDetailsScreen({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    double screenHeight = getMediaQueryHeight(context);
    double statusBarHeight = getMediaQueryPaddingTop(context);
    double appBarHeight = screenHeight / 2;

    return Scaffold(
      backgroundColor: kBlackColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //* The top header containing image....
          SliverPersistentHeader(
            delegate: SliverTopHeaderWidget(
              newsListModel: newsList,
              maxExtent: appBarHeight,
              minExtent: statusBarHeight,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          //* The rest of the screen containing news....
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: screenHeight - appBarHeight,
                  padding: EdgeInsets.symmetric(
                    vertical: getMediaQueryHeight(context, 0.02),
                    horizontal: getMediaQueryWidth(context, 0.035),
                  ),
                  decoration: BoxDecoration(
                    color: helperFunctions.isThemeLightMode(context) ? kWhiteColor : kDarkBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HorizontalImageSourceNameVerifiedBadgeWidget(generalNewsModel: newsList),
                        SizedBox(height: getMediaQueryHeight(context, 0.015)),
                        Text(
                          '${newsList.description} ${newsList.content}\n${newsList.description} ${newsList.content}\n${newsList.description} ${newsList.content}',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(wordSpacing: 1.5, letterSpacing: .5),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: getScreenArea(context, 0.00005)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: getMediaQueryWidth(context),
                    height: getMediaQueryHeight(context, 0.1),
                    decoration: BoxDecoration(
                      // color: kTransparentColor,
                      gradient: LinearGradient(
                        colors: [
                          kWhiteColor,
                          kWhiteColor,
                          kWhiteColorOp8,
                          kWhiteColorOp5,
                          kWhiteColorOp1,
                          kTransparentColor,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
