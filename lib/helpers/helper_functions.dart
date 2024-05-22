import 'package:flutter/material.dart';

final helperFunctions = HelperFunctions.instance;

class HelperFunctions {
  static HelperFunctions? _helperFunctions;
  HelperFunctions._();
  static HelperFunctions get instance {
    _helperFunctions ??= HelperFunctions._();
    return _helperFunctions!;
  }

  bool isThemeLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  List<T> combineLists<T>(lists, wallStreetListA, businessListA) {
    List<T> combinedList = [];

    // Get the length of the shortest list
    int minLength = lists.map((list) => list.length).reduce((a, b) => a < b ? a : b);

    // Iterate through the indices up to the length of the shortest list
    for (int i = 0; i < minLength; i++) {
      // Iterate through each list and add one item from each list to the combined list
      for (var list in lists) {
        combinedList.add(list[i]);
      }
    }

    return combinedList;
  }
}
