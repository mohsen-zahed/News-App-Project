import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/lists.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';

class HorizontalCategoriesWidget extends StatefulWidget {
  const HorizontalCategoriesWidget({
    super.key,
    required this.listValueNotifier,
    this.selectedIndex,
  });

  final ValueNotifier<int> listValueNotifier;
  final int? selectedIndex;

  @override
  State<HorizontalCategoriesWidget> createState() => _HorizontalCategoriesWidgetState();
}

class _HorizontalCategoriesWidgetState extends State<HorizontalCategoriesWidget> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        widget.listValueNotifier.value = widget.selectedIndex!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.03)),
      child: Row(
        children: [
          ...List.generate(
            NewsCategories.values.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.listValueNotifier.value = index;
                  });
                  debugPrint(widget.listValueNotifier.value.toString());
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.fromLTRB(4, 4, index == NewsCategories.values.length - 1 ? 4 : 0, 4),
                  padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.005)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.listValueNotifier.value == index
                          ? kPrimaryColor
                          : helperFunctions.isThemeLightMode(context)
                              ? kGreyColorShade200
                              : kGreyColorShade100Op2,
                    ),
                    color: widget.listValueNotifier.value == index ? kPrimaryColor : kTransparentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      NewsCategories.values[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: widget.listValueNotifier.value == index ? kWhiteColor : Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
