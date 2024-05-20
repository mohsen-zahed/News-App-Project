// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "welcome_text": "Welcome",
  "onboarding1_title_text": "Stay Informed!",
  "onboarding2_title_text": "Your Daily Digest!",
  "onboarding3_title_text": "Never Miss a Beat!",
  "onboarding1_subtitle_text": "Discover the latest headlines and stories from around the world!",
  "onboarding2_subtitle_text": "Get curated news tailored to your interests, delivered daily!",
  "onboarding3_subtitle_text": "Stay up-to-date with breaking news alerts and personalized updates!"
};
static const Map<String,dynamic> fa = {
  "welcome_text": "خوش آمدید",
  "onboarding1_title_text": "مطلع بمانید!",
  "onboarding2_title_text": "خلاصه روزانه شما!",
  "onboarding3_title_text": "هیچ چیز را از دست ندهید!",
  "onboarding1_subtitle_text": "آخرین عناوین و داستان‌ها از سراسر جهان را کشف کنید!",
  "onboarding2_subtitle_text": "اخبار منتخب به سلیقه‌ی شما، روزانه ارسال شود!",
  "onboarding3_subtitle_text": "با هشدارها و به‌روزرسانی‌های شخصی شده، همواره به‌روز باشید!"
};
static const Map<String,dynamic> ps = {
  "welcome_text": "ښه راغلاست",
  "onboarding1_title_text": "خبر اوسئ!",
  "onboarding2_title_text": "ستاسو ورځنی هضم!",
  "onboarding3_title_text": "هیڅ شی له لاسه مه ورکوئ!",
  "onboarding1_subtitle_text": "د نړۍ له ګوټ ګوټ څخه وروستی خبرونه او خبرونه کشف کړئ!",
  "onboarding2_subtitle_text": "ستاسو د خوښې لپاره غوره شوی خبرونه ، هره ورځ لیږل کیږی!",
  "onboarding3_subtitle_text": "د شخصی خبرتیاو او تازه معلوماتو سره تازه اوسئ!"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fa": fa, "ps": ps};
}
