import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/utils/my_media_query.dart';

class HorizontalImageSourceNameVerifiedBadgeWidget extends StatelessWidget {
  const HorizontalImageSourceNameVerifiedBadgeWidget({
    super.key,
    required this.generalNewsModel,
  });

  final dynamic generalNewsModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //* News source tv icon...
        Container(
          width: getScreenArea(context, 0.00015),
          height: getScreenArea(context, 0.00015),
          margin: EdgeInsets.fromLTRB(
            getMediaQueryWidth(context, 0.025),
            0,
            getMediaQueryWidth(context, 0.025),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    //* News source name...
                    child: Text(
                      '${generalNewsModel.source}',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  //* Source verified badge...
                  Image.asset(
                    verifiedIconPath,
                    width: getScreenArea(context, 0.00005),
                    height: getScreenArea(context, 0.00005),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              //* News author text...
              Text(
                'By ${generalNewsModel.author}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kGreyColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
