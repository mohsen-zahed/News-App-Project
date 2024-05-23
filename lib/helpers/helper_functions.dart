import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/images_paths.dart';

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

  String getFileType(String filePath) {
    String filename = filePath.split('/').last;

    // Split the filename by '.' and get the last segment
    String imagePath = filename.split('.').last.toLowerCase();

    if (imagePath.contains('jpg') || imagePath.contains('jpeg') || imagePath.contains('png') || imagePath.contains('JPEG')) {
      return filePath;
    } else if (imagePath.contains('webp')) {
      return imageDownloadFailed;
    } else {
      return imageDownloadFailed;
    }
  }

  void showSnackBar(BuildContext context, String message, int durationInMilli) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(duration: Duration(milliseconds: durationInMilli), content: Text(message)),
      );
  }
}
