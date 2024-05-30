import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/have_or_dont_have_account_and_forgot_pass_texts.dart.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/submit_button_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/sign_up_screen.dart/sign_up_screen.dart';
import 'package:news_app/utils/my_media_query.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                      controller: _emailController,
                      focusNode: _emailNode,
                      onSumbit: (value) {},
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
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      onSumbit: (value) {},
                      suffixIcon: showPassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                      isObsecured: showPassword,
                    ),
                    SizedBox(height: getScreenArea(context, 0.00002)),
                    HaveOrDontHaveAccountAndForgotPassTexts(
                      onAccountTextsTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      text: "Don't have an account?",
                      text2: "SignUp",
                      isLoginScreen: true,
                      onRightTextTap: () {},
                    ),
                    SizedBox(height: getScreenArea(context, 0.0003)),
                    SubmitButtonWidget(
                      buttonText: 'Login',
                      onPressed: () {},
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
