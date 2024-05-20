import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MySmoothPageIndicator {
  static SmoothPageIndicator pageIndicator({
    required PageController controller,
    required int count,
    required Color dotColor,
    required Color activeDotColor,
  }) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      axisDirection: Axis.horizontal,
      effect: WormEffect(
        spacing: 5,
        radius: 50,
        dotWidth: 5,
        dotHeight: 5,
        dotColor: dotColor,
        activeDotColor: activeDotColor,
      ),
    );
  }
}
