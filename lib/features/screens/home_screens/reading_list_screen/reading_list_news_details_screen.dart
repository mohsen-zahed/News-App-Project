import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/widgets/reading_news_details_horizontal_image_source_name_verified_badge_widget.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/widgets/reading_news_details_sliver_top_header_widget.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';

class ReadingListNewsDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> readingNewsList;
  const ReadingListNewsDetailsScreen({super.key, required this.readingNewsList});

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
            delegate: ReadingNewsDetailsSliverTopHeaderWidget(
              newsListModel: readingNewsList,
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
                    horizontal: getMediaQueryWidth(context, 0.05),
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
                        ValueListenableBuilder(
                          valueListenable: FirebaseUserInfoDataSourceImp.savedListNotifier,
                          builder: (context, value, child) {
                            return ReadingNewsDetailsHorizontalImageSourceNameVerifiedBadgeWidget(
                              generalNewsModel: readingNewsList,
                            );
                          },
                        ),
                        SizedBox(height: getScreenArea(context, 0.00003)),
                        Text(
                          '${readingNewsList['description']} ${readingNewsList['content']}\n${readingNewsList['description']} ${readingNewsList['content']}\n${readingNewsList['description']} ${readingNewsList['content']}\n${readingNewsList['description']} ${readingNewsList['content']}',
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
                    height: getScreenArea(context, 0.00022),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.screen,
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
