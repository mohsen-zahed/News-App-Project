import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';

class SingleHorizontalNewsWidget extends StatelessWidget {
  final dynamic newsModel;
  const SingleHorizontalNewsWidget({
    super.key,
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.035)),
      child: Column(
        children: [
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Row(
              children: [
                //* Card news image... left space...
                Expanded(
                  child: SizedBox(
                    height: getMediaQueryHeight(context),
                    child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: newsModel.imageUrl),
                  ),
                ),
                const SizedBox(width: 10),
                //* Card news texts... right space
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //* News author...
                        Text(
                          'By ${newsModel.author}',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //* News description...
                        Expanded(
                          child: Text(
                            newsModel.description,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //* Column for Row and publish date...
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Row with image, source, verified badge...
                            Row(
                              children: [
                                Container(
                                  width: getScreenArea(context, 0.00006),
                                  height: getScreenArea(context, 0.00006),
                                  margin: EdgeInsets.fromLTRB(
                                    getMediaQueryWidth(context, 0),
                                    0,
                                    getMediaQueryWidth(context, 0.01),
                                    0,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(cnnIconTvPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: getMediaQueryWidth(context, 0.35)),
                                  child: Text(
                                    newsModel.source,
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: getScreenArea(context, 0.000035)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Image.asset(
                                  verifiedIconPath,
                                  width: getScreenArea(context, 0.000035),
                                  height: getScreenArea(context, 0.000035),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            //* Publish date...
                            Text(
                              newsModel.publishedAt,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                            ),
                          ],
                        ),
                      ],
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
