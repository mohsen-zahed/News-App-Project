import 'package:flutter/material.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/widget/all_news_search_bar.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/widget/all_news_vertical_list_view.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/horizontal_categories_widget.dart';
import 'package:news_app/utils/my_app_bar.dart';
import 'package:news_app/utils/my_media_query.dart';

class AllNewsScreen extends StatefulWidget {
  static const String id = '/all_news_screen';
  const AllNewsScreen({super.key, required this.allNewsList, this.index});
  final List<dynamic> allNewsList;
  final int? index;

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  final TextEditingController _searchTextEditingController = TextEditingController();
  final ValueNotifier<String> _searchNotifier = ValueNotifier('');
  final ValueNotifier<int> _tabNotifier = ValueNotifier(0);

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
    _searchNotifier.dispose();
    _tabNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, child: const Text('Explore All News')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Search box...
            AllNewsSearchBar(
              onSearchChanged: (value) {
                setState(() {
                  _searchNotifier.value = value;
                });
              },
              searchNotifier: _searchNotifier,
            ),
            SizedBox(height: getMediaQueryHeight(context, 0.02)),
            //* Categories tab bar...
            HorizontalCategoriesWidget(
              listValueNotifier: _tabNotifier,
              selectedIndex: widget.index ?? 0,
            ),
            SizedBox(height: getMediaQueryHeight(context, 0.02)),
            //* The space for displaying all news...
            AllNewsVerticalListView(
              tabNotifier: _tabNotifier,
              searchNotifier: _searchNotifier,
              allNewsList: widget.allNewsList,
            ),
            SizedBox(height: getMediaQueryHeight(context, 0.02)),
          ],
        ),
      ),
    );
  }
}
