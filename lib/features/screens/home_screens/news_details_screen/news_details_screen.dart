import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/screens/home_screens/news_details_screen/widgets/horizontal_image_source_name_verified_badge_widget.dart';
import 'package:news_app_project/features/screens/home_screens/news_details_screen/widgets/sliver_top_header_widget.dart';
import 'package:news_app_project/helpers/helper_functions.dart';
import 'package:news_app_project/utils/my_media_query.dart';

class NewsDetailsScreen extends StatelessWidget {
  final GeneralNewsModel generalNewsModel;
  const NewsDetailsScreen({super.key, required this.generalNewsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //* The top header containing image....
          SliverPersistentHeader(
            delegate: TopHeaderWidget(
              generalNewsModel: generalNewsModel,
              maxExtent: getmediaQueryHeight(context) / 2,
              minExtent: MediaQuery.of(context).padding.top,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          //* The rest of the screen containing news....
          SliverToBoxAdapter(
            child: Container(
              height: getmediaQueryHeight(context),
              padding: EdgeInsets.symmetric(
                vertical: getmediaQueryHeight(context, 0.02),
                horizontal: getMediaQueryWidth(context, 0.035),
              ),
              decoration: BoxDecoration(
                color: helperFunctions.isThemeLightMode(context) ? kWhiteColor : kDarkBackgroundColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  HorizontalImageSourceNameVerifiedBadgeWidget(generalNewsModel: generalNewsModel),
                  const SizedBox(height: 10),
                  Text(
                      '${generalNewsModel.description} ${generalNewsModel.content}\n${generalNewsModel.description} ${generalNewsModel.content}\n${generalNewsModel.description} ${generalNewsModel.content}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(wordSpacing: 1.5, letterSpacing: .5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
