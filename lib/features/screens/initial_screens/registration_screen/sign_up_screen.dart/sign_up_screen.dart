import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/dont_have_account_and_forgot_pass_texts.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/google_login_button.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/or_divider_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/utils/my_media_query.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/sign_up_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
