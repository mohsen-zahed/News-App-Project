import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/lists.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/news_details_screen.dart';
import 'package:news_app/utils/my_media_query.dart';

class HorizontalTwoCardsVerticalWithTitleText extends StatelessWidget {
  final List<dynamic> newsList;
  final GestureTapCallback onViewAllTap;
  final int comingIndex;
  final String titleText;
  const HorizontalTwoCardsVerticalWithTitleText({
    super.key,
    required this.newsList,
    required this.onViewAllTap,
    required this.titleText,
    required this.comingIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(titleText, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text('View all', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        //* Top padding between title and card's column...
        SizedBox(height: getMediaQueryHeight(context, 0.01)),
        AspectRatio(
          //* Height of the entire card containing two single cards vertically, is 1/1.03 of the screen height...
          aspectRatio: 1 / 1.03,
          child: PageView.builder(
            itemCount: newsList[comingIndex].length ~/ 2,
            itemBuilder: (context, realIndex) {
              final startIndex = realIndex * 2;
              return Column(
                children: [
                  ...List.generate(
                    2,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NewsDetailsScreen(newsList: listOfAllNewsListsHome[comingIndex][startIndex + index])));
                      },
                      child: SingleHorizontalNewsWidget(
                        newsModel: newsList[comingIndex][startIndex + index],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
