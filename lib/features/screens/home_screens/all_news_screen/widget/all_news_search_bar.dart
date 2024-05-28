import 'package:flutter/cupertino.dart';
import 'package:news_app/utils/my_media_query.dart';

class AllNewsSearchBar extends StatelessWidget {
  final ValueNotifier searchNotifier;
  final Function(String) onSearchChanged;
  const AllNewsSearchBar({
    super.key,
    required this.searchNotifier,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: searchNotifier,
      builder: (context, value, child) => Container(
        height: getMediaQueryHeight(context, 0.05),
        margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.05)),
        child: CupertinoSearchTextField(
          placeholder: 'Explore all news...',
          onChanged: onSearchChanged,
        ),
      ),
    );
  }
}
