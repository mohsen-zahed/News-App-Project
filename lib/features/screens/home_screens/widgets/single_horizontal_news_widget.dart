import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:news_app_project/widgets/custom_cached_network_image.dart';

class SingleHorizontalNewsWidget extends StatelessWidget {
  final GeneralNewsModel newsModel;
  const SingleHorizontalNewsWidget({
    super.key,
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 2 / 1,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: getmediaQueryHeight(context),
                  child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: newsModel.imageUrl),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: getmediaQueryHeight(context, 0.015)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By ${newsModel.source}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          newsModel.description,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade800),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        newsModel.publishedAt,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 1.5,
          decoration: BoxDecoration(
            color: kGreyColorShade200,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
