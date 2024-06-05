import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/bloc/news_details_bloc/bloc/bookmark_button_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/horizontal_image_source_name_verified_badge_widget.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/sliver_top_header_widget.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';

class NewsDetailsScreen extends StatefulWidget {
  final dynamic newsList;
  const NewsDetailsScreen({super.key, required this.newsList});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  BookmarkButtonBloc? bloc;
  StreamSubscription? streamSubscription;
  @override
  void dispose() {
    super.dispose();
    bloc?.close();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getMediaQueryHeight(context);
    double statusBarHeight = getMediaQueryPaddingTop(context);
    double appBarHeight = screenHeight / 2;

    return BlocProvider<BookmarkButtonBloc>(
      create: (context) {
        bloc = BookmarkButtonBloc(firebaseUserInfoRepository);
        streamSubscription = bloc?.stream.listen((state) {
          if (state is BookmarkButtonSuccess) {
            helperFunctions.showSnackBar(context, 'Item added to reading list successfully', 3000);
          } else if (state is RemoveBookmarkButtonSuccess) {
            helperFunctions.showSnackBar(context, 'Item removed from reading list successfully', 3000);
          } else if (state is BookmarkButtonFailed) {
            helperFunctions.showSnackBar(context, 'Could not add item right now', 3000);
          } else if (state is RemoveBookmarkButtonFailed) {
            helperFunctions.showSnackBar(context, 'Could not remove item right now', 3000);
          }
        });
        return bloc!;
      },
      child: Scaffold(
        backgroundColor: kBlackColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            //* The top header containing image....
            SliverPersistentHeader(
              delegate: SliverTopHeaderWidget(
                newsListModel: widget.newsList,
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
                          HorizontalImageSourceNameVerifiedBadgeWidget(generalNewsModel: widget.newsList),
                          SizedBox(height: getScreenArea(context, 0.00003)),
                          Text(
                            '${widget.newsList.description} ${widget.newsList.content}\n${widget.newsList.description} ${widget.newsList.content}\n${widget.newsList.description} ${widget.newsList.content}',
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
      ),
    );
  }
}
