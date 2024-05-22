import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/screens/home_screens/widgets/single_horizontal_news_widget.dart';
import 'package:news_app_project/utils/my_media_query.dart';

class VerticalRecommendationsListWidget extends StatelessWidget {
  final List<GeneralNewsModel> generalNewsModel;
  const VerticalRecommendationsListWidget({
    super.key,
    required this.generalNewsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Recommendations', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {},
                child: Text('View all', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          ...List.generate(
            generalNewsModel.length,
            (index) => SingleHorizontalNewsWidget(
              newsModel: generalNewsModel[index],
            ),
          ),
        ],
      ),
    );
  }
}
