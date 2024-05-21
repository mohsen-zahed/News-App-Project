import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final double borderRadius;
  final String imageUrl;
  final bool? showIndicator;
  const CustomCachedNetworkImage({
    super.key,
    required this.borderRadius,
    required this.imageUrl,
    this.showIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: showIndicator != null
              ? showIndicator == true
                  ? const CupertinoActivityIndicator()
                  : const SizedBox()
              : const SizedBox(),
        ),
        // errorWidget: (context, url, error) => Image.asset(
        //   ImagesPaths.loadingImageErrorPath,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
