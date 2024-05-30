import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/custom_divider.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, 0.03),
      ),
      child: Row(
        children: [
          Expanded(child: CustomDivider(color: kGreyColorShade500)),
          Text('OR', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500)),
          Expanded(child: CustomDivider(color: kGreyColorShade500)),
        ],
      ),
    );
  }
}
