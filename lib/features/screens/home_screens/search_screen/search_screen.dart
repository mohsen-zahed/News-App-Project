import 'package:flutter/material.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/horizontal_categories_widget.dart';
import 'package:news_app/widgets/custom_divider.dart';
import 'package:news_app/features/screens/home_screens/search_screen/widgets/search_field.dart';
import 'package:news_app/features/screens/home_screens/search_screen/widgets/search_result_body.dart';

class SearchScreen extends StatefulWidget {
  static const String id = '/search_screen';
  final List<dynamic> searchList;
  const SearchScreen({super.key, required this.searchList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  final ValueNotifier<int> tabNotifier = ValueNotifier<int>(0);
  final TextEditingController searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchNotifier.dispose();
    searchTextEditingController.dispose();
    tabNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchField(searchTextEditingController: searchTextEditingController, searchNotifier: searchNotifier),
            const CustomDivider(),
            HorizontalCategoriesWidget(listValueNotifier: tabNotifier,selectedIndex: 0),
            const CustomDivider(),
            SearchResultBody(tabNotifier: tabNotifier, searchNotifier: searchNotifier, widget: widget),
          ],
        ),
      ),
    );
  }
}
