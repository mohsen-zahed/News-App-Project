import 'package:flutter/material.dart';
import 'package:news_app/utils/my_media_query.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.searchTextEditingController,
    required this.searchNotifier,
  });

  final TextEditingController searchTextEditingController;
  final ValueNotifier<String> searchNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
