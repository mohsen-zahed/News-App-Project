import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/data/models/general_news_model.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/news_details_screen.dart';
import 'package:news_app/utils/my_media_query.dart';

class SearchScreen extends StatefulWidget {
  static const String id = '/search_screen';
  final List<GeneralNewsModel> newsList;
  const SearchScreen({super.key, required this.newsList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ValueNotifier<String> searchNotifier = ValueNotifier('');
  final TextEditingController searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchNotifier.dispose();
    searchTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
              child: TextField(
                controller: searchTextEditingController,
                onChanged: (value) {
                  searchNotifier.value = searchTextEditingController.text;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'Search news here...',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.5,
              margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
              decoration: BoxDecoration(
                color: kGreyColorShade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchNotifier,
                builder: (context, value, child) {
                  List<GeneralNewsModel> items = [];
                  List<GeneralNewsModel> searchNewsList = widget.newsList;
                  if (searchNotifier.value.isNotEmpty) {
                    items = searchNewsList.where((element) {
                      return (element.title.contains(searchNotifier.value.toLowerCase()) ||
                              element.title.contains(searchNotifier.value.toUpperCase())) ||
                          (element.description.contains(searchNotifier.value.toLowerCase()) ||
                              element.description.contains(searchNotifier.value.toUpperCase())) ||
                          (element.source.contains(searchNotifier.value.toLowerCase()) ||
                              element.source.contains(searchNotifier.value.toUpperCase())) ||
                          (element.content.contains(searchNotifier.value.toLowerCase()) ||
                              element.content.contains(searchNotifier.value.toUpperCase())) ||
                          (element.author.contains(searchNotifier.value.toLowerCase()) ||
                              element.author.contains(searchNotifier.value.toUpperCase()));
                    }).toList();
                  } else {
                    items = [];
                  }
                  if (items.isEmpty) {
                    return Center(
                        child: Text(
                      'No record found!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ));
                  } else {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => NewsDetailsScreen(generalNewsModel: items[index])));
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
          ],
        ),
      ),
    );
  }
}
