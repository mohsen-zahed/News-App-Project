import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/helpers/helper_functions.dart';
import 'package:news_app_project/utils/my_media_query.dart';
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
                  imageProvider: NetworkImage(imageUrl),
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
