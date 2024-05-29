import 'package:easy_localization/easy_localization.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/translations/locale_keys.g.dart';

List<Map<String, dynamic>> onboardingList = [
  {
    'image': onboardingBackground1Path,
    'title': LocaleKeys.onboarding1_title_text.tr(),
    'subtitle': LocaleKeys.onboarding1_subtitle_text.tr(),
  },
  {
    'image': onboardingBackground2Path,
    'title': LocaleKeys.onboarding2_title_text.tr(),
    'subtitle': LocaleKeys.onboarding2_subtitle_text.tr(),
  },
  {
    'image': onboardingBackground3Path,
    'title': LocaleKeys.onboarding3_title_text.tr(),
    'subtitle': LocaleKeys.onboarding3_subtitle_text.tr(),
  },
];

enum NewsCategories {
  all,
  wJS,
  technology,
  business,
}

List<dynamic> allNewsListsHome = [];
List<dynamic> allNewsListAllScreen = [];

List<String> newsTitles = ['Wall Street Journal', 'Technology News', 'Business News'];
