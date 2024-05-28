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
        Container(
          width: getMediaQueryWidth(context, 0.1),
          height: getMediaQueryWidth(context, 0.1),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: getMediaQueryWidth(context, 0.7)),
                  child: Text(
                    generalNewsModel.source,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                Image.asset(
                  verifiedIconPath,
                  width: getMediaQueryWidth(context, 0.04),
                  height: getMediaQueryWidth(context, 0.04),
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Text(
              'By ${generalNewsModel.author}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kGreyColor),
            ),
          ],
        ),
      ],
    );
  }
}
