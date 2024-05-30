import 'package:flutter/material.dart';

double getMediaQueryWidth(BuildContext context, [double? width]) {
  return MediaQuery.of(context).size.width * (width ?? 1);
}

double getMediaQueryHeight(BuildContext context, [double? height]) {
  return MediaQuery.of(context).size.height * (height ?? 1);
}

double getMediaQueryPaddingTop(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double getScreenArea(BuildContext context, [double? number]) {
  return (getMediaQueryWidth(context) * getMediaQueryHeight(context)) * (number ?? 1);
}
