import 'package:flutter/material.dart';

AppBar myAppBar({required BuildContext context, required Widget child, List<Widget>? actions}) {
  return AppBar(
    title: child,
    actions: actions ?? [],
  );
}
