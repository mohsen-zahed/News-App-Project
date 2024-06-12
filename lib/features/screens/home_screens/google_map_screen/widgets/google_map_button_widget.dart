import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class GoogleMapButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  const GoogleMapButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getScreenArea(context, 0.000115),
        height: getScreenArea(context, 0.000115),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(1),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 3,
              color: kBlackColorOp3,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}
