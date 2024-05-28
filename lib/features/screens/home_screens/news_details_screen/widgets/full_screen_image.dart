import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(imageUrl),
                  loadingBuilder: (context, event) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  backgroundDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              Positioned(
                top: getMediaQueryHeight(context, 0.02),
                left: getMediaQueryWidth(context, 0.035),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined, color: helperFunctions.isThemeLightMode(context) ? kBlackColor : kWhiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
