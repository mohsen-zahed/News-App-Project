import 'package:flutter/material.dart';
import 'package:news_app/config/constants/images_paths.dart';

final helperFunctions = HelperFunctions.instance;

class HelperFunctions {
  static HelperFunctions? _helperFunctions;
  HelperFunctions._();
  static HelperFunctions get instance {
    _helperFunctions ??= HelperFunctions._();
    return _helperFunctions!;
  }

//** ThemeFunctions starts here ***//
//**
  bool isThemeLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
//**
//** ThemeFunctions ends here ***//

//** Theme Functions starts here ***//
//**
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
//**
//** Theme Functions ends here ***//

//** File Functions starts here ***//
//**
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
//**
//** File Functions ends here ***//

//** PopUp Functions start here ***//
//**
  void showSnackBar(BuildContext context, String message, int durationInMilli) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(duration: Duration(milliseconds: durationInMilli), content: Text(message)),
      );
  }

  void showRapidSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  void showConfirmationDialogBox(BuildContext context, String confirmationText, {required Function onConfirm, required Function onCancel}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reload Screen?'),
          content: Text(confirmationText),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                onCancel();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

void showInfinitTimeSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(duration: const Duration(days: 365), content: Text(message)),
  );
}
//**
//** PopUp Functions end here ***//

//** Connectivity Functions starts here ***//
//**

//**
//** Connectivity Functions ends here ***//

//** Data Functions starts here ***//
//**
String getFormattedChristianDate() {
  var date = DateTime.now().toString();
  var dateStamp = DateTime.parse(date);
  return '${dateStamp.year}-${dateStamp.month}-${dateStamp.day}::${dateStamp.hour}-${dateStamp.minute}-${dateStamp.second}';
}
//**
//** Data Functions ends here ***//
