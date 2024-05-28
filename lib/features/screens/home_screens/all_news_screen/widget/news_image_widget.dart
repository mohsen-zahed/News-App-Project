import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/all_news_screen.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/full_screen_image.dart';
import 'package:news_app/utils/my_media_query.dart';

class NewsImageWidget extends StatelessWidget {
  final int index;
  const NewsImageWidget({
    super.key,
    required this.widget,
    required ValueNotifier<int> tabNotifier,
    required this.index,
  }) : _tabNotifier = tabNotifier;

  final AllNewsScreen widget;
  final ValueNotifier<int> _tabNotifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imageUrl: widget.allNewsList[_tabNotifier.value][index].imageUrl),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 2 / 1.2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kGreyColorShade300,
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.allNewsList[_tabNotifier.value][index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
