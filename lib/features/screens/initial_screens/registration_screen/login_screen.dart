import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/custom_divider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: getMediaQueryWidth(context),
          height: getMediaQueryHeight(context),
          decoration: const BoxDecoration(
            color: kBlackColor,
            image: DecorationImage(
              image: AssetImage(onboardingBackground1Path),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getScreenArea(context, 0.0002)),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(getScreenArea(context, 0.0001)),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          lightAppLogoPath,
                          height: getScreenArea(context, 0.0004),
                        ),
                      ),
                    ),
                    SizedBox(height: getScreenArea(context, 0.0002)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
                      child: Text(
                        'Login/SignUp to perceed to application!',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: getScreenArea(context, 0.00005)),
                    RegistrationTextFieldWidget(
                      hintText: 'Username or email',
                      prefixIcon: Icons.email,
                      controller: emailController,
                    ),
                    SizedBox(height: getScreenArea(context, 0.00005)),
                    RegistrationTextFieldWidget(
                      onShowPasswordTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                      suffixIcon: showPassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                      isObsecured: showPassword,
                    ),
                    SizedBox(height: getScreenArea(context, 0.00002)),
                    DontHaveAccountAndForgotPasswordTexts(
                      onSignUpTap: TapGestureRecognizer()..onTap = () {},
                      onForgotPassTap: () {},
                    ),
                    SizedBox(height: getScreenArea(context, 0.00012)),
                    const OrDividerWidget(),
                    SizedBox(height: getScreenArea(context, 0.00012)),
                    GoogleLoginButton(
                      onButtonTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final GestureTapCallback onButtonTap;
  const GoogleLoginButton({
    super.key,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        width: getMediaQueryWidth(context),
        padding: EdgeInsets.symmetric(vertical: getScreenArea(context, 0.000035)),
        margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.07)),
        decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(googleIconPath, height: getScreenArea(context, 0.0001)),
            SizedBox(width: getMediaQueryWidth(context, 0.025)),
            Text('Login with Google', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

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

class DontHaveAccountAndForgotPasswordTexts extends StatelessWidget {
  final TapGestureRecognizer onSignUpTap;
  final GestureTapCallback onForgotPassTap;
  const DontHaveAccountAndForgotPasswordTexts({
    super.key,
    required this.onSignUpTap,
    required this.onForgotPassTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kGreyColorShade400,
                    decoration: TextDecoration.underline,
                    decorationColor: kGreyColorShade400,
                  ),
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: "SignUp",
                    recognizer: onSignUpTap,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: GestureDetector(
              onTap: onForgotPassTap,
              child: Text(
                'Forgot password?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kGreyColorShade400,
                      decoration: TextDecoration.underline,
                      decorationColor: kGreyColorShade400,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final Color? backgroundColor;
  final IconData? suffixIcon;
  final bool? isObsecured;
  final GestureTapCallback? onShowPasswordTap;
  const RegistrationTextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.backgroundColor,
    this.suffixIcon,
    this.isObsecured,
    this.onShowPasswordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenArea(context, 0.00015),
      margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.07)),
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.01)),
      decoration: BoxDecoration(
        color: backgroundColor ?? kGreyColorShade100Op2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isObsecured ?? false,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
            prefixIcon: Icon(prefixIcon, color: kGreyColorShade100Op2),
            suffixIcon: GestureDetector(
              onTap: onShowPasswordTap,
              child: Icon(suffixIcon, color: kGreyColorShade100Op2),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: hintText,
          ),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kGreyColorShade200),
        ),
      ),
    );
  }
}
