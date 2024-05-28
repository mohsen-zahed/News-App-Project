import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/news_details_screen.dart';
import 'package:news_app/features/screens/home_screens/search_screen/search_screen.dart';

class SearchResultBody extends StatelessWidget {
  const SearchResultBody({
    super.key,
    required this.tabNotifier,
    required this.searchNotifier,
    required this.widget,
  });

  final ValueNotifier<int> tabNotifier;
  final ValueNotifier<String> searchNotifier;
  final SearchScreen widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: tabNotifier,
        builder: (context, value, child) => ValueListenableBuilder(
          valueListenable: searchNotifier,
          builder: (context, value, child) {
            List<dynamic> items = [];
            List<dynamic> searchNewsList = widget.searchList[tabNotifier.value];
            if (searchNotifier.value.isNotEmpty) {
              items = searchNewsList.where((element) {
                return (element.title.contains(searchNotifier.value.toLowerCase()) || element.title.contains(searchNotifier.value.toUpperCase())) ||
                    (element.description.contains(searchNotifier.value.toLowerCase()) ||
                        element.description.contains(searchNotifier.value.toUpperCase())) ||
                    (element.source.contains(searchNotifier.value.toLowerCase()) || element.source.contains(searchNotifier.value.toUpperCase())) ||
                    (element.content.contains(searchNotifier.value.toLowerCase()) || element.content.contains(searchNotifier.value.toUpperCase())) ||
                    (element.author.contains(searchNotifier.value.toLowerCase()) || element.author.contains(searchNotifier.value.toUpperCase()));
              }).toList();
            } else {
              items = searchNewsList;
            }
            if (items.isEmpty) {
              return Center(
                  child: Text(
                tabNotifier.value == 0
                    ? 'No record found - AllNews'
                    : tabNotifier.value == 1
                        ? 'No record found - WJS'
                        : tabNotifier.value == 2
                            ? 'No record found - Technology'
                            : 'No record found - Business',
                style: Theme.of(context).textTheme.titleMedium,
              ));
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => NewsDetailsScreen(newsList: items[index])));
                    },
                    child: SingleHorizontalNewsWidget(
                      newsModel: items[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
