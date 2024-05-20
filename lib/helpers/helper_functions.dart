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
}
