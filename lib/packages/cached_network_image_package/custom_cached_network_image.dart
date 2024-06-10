import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final double borderRadius;
  final String imageUrl;
  final bool? showIndicator;
  final BoxFit? fit;
  const CustomCachedNetworkImage({
    super.key,
    required this.borderRadius,
    required this.imageUrl,
    this.showIndicator,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Center(
          child: showIndicator != null
              ? showIndicator == true
                  ? const CupertinoActivityIndicator()
                  : const SizedBox()
              : const SizedBox(),
        ),
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.broken_image_rounded,
          color: kGreyColorShade300,
          size: getScreenArea(context, 0.00015),
        ),
      ),
    );
  }
}
