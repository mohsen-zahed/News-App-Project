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

//* Used in home_screen.dart
List<dynamic> listOfAllNewsListsHome = [];
//* Used in home_screen.dart
List<dynamic> allNewsListAllScreen = [];

//* Used in home_screen.dart
List<String> newsTitles = ['Wall Street Journal', 'Technology News', 'Business News'];

//* Used in helpers folder...
List<String> emailErrorList = [];
List<String> passwordErrorList = [];

//* Used in app globally...
dynamic savedNewsList = [];
