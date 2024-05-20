import 'package:flutter/material.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/config/constants/lists.dart';
import 'package:news_app_project/features/screens/home_screens/home_screen.dart';
import 'package:news_app_project/features/screens/initial_screens/onboarding_screen/widgets/custom_onboarding_button.dart';
import 'package:news_app_project/helpers/helper_functions.dart';
import 'package:news_app_project/packages/smooth_page_indicator/smooth_page_indicator.dart';
import 'package:news_app_project/utils/my_media_query.dart';

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
                  onPressed: () {
                    if (index == 2) {
                      Navigator.pushNamed(context, HomeScreen.id);
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
