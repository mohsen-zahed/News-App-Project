import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/my_media_query.dart';

class ScreenLoadingWidget extends StatelessWidget {
  final String loadingText;
  const ScreenLoadingWidget({
    super.key,
    required this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getMediaQueryHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const CupertinoActivityIndicator(),
          const SizedBox(height: 10),
          Text(loadingText, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
