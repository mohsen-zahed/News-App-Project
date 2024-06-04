import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/lists.dart';
import 'package:news_app/features/screens/initial_screens/onboarding_screen/widgets/custom_onboarding_button.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/login_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
import 'package:news_app/packages/smooth_page_indicator/smooth_page_indicator.dart';
import 'package:news_app/utils/my_media_query.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = '/onboarding_screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingList.length,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              itemBuilder: (context, index) => Image.asset(
                onboardingList[index]['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: getMediaQueryWidth(context, 0.8),
                  ),
                  child: Text(
                    onboardingList[index]['title'],
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: getMediaQueryWidth(context, 0.8),
                  ),
                  child: Text(
                    onboardingList[index]['subtitle'],
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MySmoothPageIndicator.pageIndicator(
                  controller: _controller,
                  count: onboardingList.length,
                  dotColor: helperFunctions.isThemeLightMode(context) ? kSecondaryColor : kPrimaryColor,
                  activeDotColor: helperFunctions.isThemeLightMode(context) ? kPrimaryColor : kSecondaryColor,
                ),
                CustomOnboardingButton(
                  controller: _controller,
                  buttonText: index == 2 ? 'Enter' : 'Next',
                  onPressed: () async {
                    if (index == 2) {
                      await MySharedPreferencesPackage.instance.storeOnboardingStatusToLocale(hasSeenOnboardingKey, true).then((value) async {
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                      }).onError((error, stackTrace) {
                        helperFunctions.showSnackBar(context, error.toString(), 4000);
                      });
                    }
                    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
