import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/config/constants/images_paths.dart';
import 'package:news_app_project/features/data/models/news_model.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HorizontalBannerSliderWidget extends StatefulWidget {
  final List<NewsModel> newsModelList;
  const HorizontalBannerSliderWidget({
    super.key,
    required this.newsModelList,
  });

  @override
  State<HorizontalBannerSliderWidget> createState() => _HorizontalBannerSliderWidgetState();
}

class _HorizontalBannerSliderWidgetState extends State<HorizontalBannerSliderWidget> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3 / 1.75,
          child: PageView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              //* Main image holder box...
              return Container(
                width: getMediaQueryWidth(context),
                margin: EdgeInsets.fromLTRB(
                  getMediaQueryWidth(context, 0.025),
                  0,
                  getMediaQueryWidth(context, 0.025),
                  0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.newsModelList[index].imageUrl),
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
                                    widget.newsModelList[index].sourceName,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.newsModelList[index].description,
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
          count: 3,
          axisDirection: Axis.horizontal,
          effect: WormEffect(
            spacing: 5,
            radius: 50,
            dotWidth: 35,
            dotHeight: 3,
            dotColor: kGreyColorShade300,
            activeDotColor: kGreyColor,
          ),
        ),
      ],
    );
  }
}
