import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/config/constants/images_paths.dart';
import 'package:news_app_project/features/data/models/banners_news_model.dart';
import 'package:news_app_project/helpers/helper_functions.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalBreakingNewsSliderWidget extends StatefulWidget {
  final List<BannersNewsModel> bannersModelList;
  final GestureTapCallback onViewAllTap;
  const HorizontalBreakingNewsSliderWidget({
    super.key,
    required this.bannersModelList,
    required this.onViewAllTap,
  });

  @override
  State<HorizontalBreakingNewsSliderWidget> createState() => _HorizontalBreakingNewsSliderWidgetState();
}

class _HorizontalBreakingNewsSliderWidgetState extends State<HorizontalBreakingNewsSliderWidget> {
  final PageController _controller = PageController(initialPage: 0);
  Timer? _timer;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    // _startAutoScroll();
  }

  void _startAutoScroll() {
    // Set up a timer to automatically scroll to the next page
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentPage = ((_currentPage + 1) % widget.bannersModelList.length).round();
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Dispose timer and page controller
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.035)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Breaking News', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: widget.onViewAllTap,
                child: Text('View all', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        SizedBox(height: getmediaQueryHeight(context, 0.015)),
        AspectRatio(
          aspectRatio: 3 / 1.75,
          child: PageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.bannersModelList.length,
            itemBuilder: (context, index) {
              //* Main image holder box...
              return Container(
                // width: getMediaQueryWidth(context),
                margin: EdgeInsets.fromLTRB(
                  getMediaQueryWidth(context, 0.025),
                  0,
                  getMediaQueryWidth(context, 0.025),
                  0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.bannersModelList[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                //* Content inside the image holder box...
                child: Stack(
                  children: [
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getMediaQueryWidth(context, 0.03),
                        vertical: getmediaQueryHeight(context, 0.015),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Sports',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: getMediaQueryWidth(context, 0.08),
                                    height: getMediaQueryWidth(context, 0.08),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(cnnIconTvPath),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.bannersModelList[index].sourceName,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.bannersModelList[index].description,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        //* Scroll indicators...
        SmoothPageIndicator(
          controller: _controller,
          count: widget.bannersModelList.length,
          axisDirection: Axis.horizontal,
          effect: ScrollingDotsEffect(
            spacing: 5,
            radius: 5,
            dotWidth: 7,
            dotHeight: 7,
            dotColor: helperFunctions.isThemeLightMode(context) ? kGreyColorShade300 : kGreyColorShade600,
            activeDotColor: helperFunctions.isThemeLightMode(context) ? kGreyColorShade600 : kGreyColorShade300,
          ),
        ),
      ],
    );
  }
}
