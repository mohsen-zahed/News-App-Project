import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/have_or_dont_have_account_and_forgot_pass_texts.dart.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/google_login_button.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/or_divider_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/submit_button_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/sign_up_screen.dart/bloc/bloc/sign_up_bloc.dart';
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
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmPasswordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
  }

  bool showPass = false;
  bool showConfirmPass = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(firebaseAuthRepository),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: getMediaQueryWidth(context),
            height: getMediaQueryHeight(context),
            decoration: const BoxDecoration(
              color: kBlackColor,
              image: DecorationImage(
                image: AssetImage(onboardingBackground3Path),
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
                      SizedBox(height: getScreenArea(context, 0.0001)),
                      //* TETCO NEWS image...
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
                      SizedBox(height: getScreenArea(context, 0.00012)),
                      //* Registration text...
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
                        child: Text(
                          'SignUp before continuing to application!',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Email field...
                      RegistrationTextFieldWidget(
                        hintText: 'Username or email',
                        prefixIcon: Icons.email,
                        controller: emailController,
                        focusNode: emailNode,
                        onSumbit: (value) {
                          emailNode.requestFocus(passwordNode);
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Password field...
                      RegistrationTextFieldWidget(
                        onShowPasswordTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        controller: passwordController,
                        suffixIcon: showPass ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                        isObsecured: showPass,
                        focusNode: passwordNode,
                        onSumbit: (value) {
                          emailNode.requestFocus(confirmPasswordNode);
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Confirm password field...
                      RegistrationTextFieldWidget(
                        onShowPasswordTap: () {
                          setState(() {
                            showConfirmPass = !showConfirmPass;
                          });
                        },
                        hintText: 'Confirm password',
                        prefixIcon: Icons.lock,
                        controller: confirmPasswordController,
                        suffixIcon: showConfirmPass ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                        isObsecured: showConfirmPass,
                        focusNode: confirmPasswordNode,
                        onSumbit: (value) {
                          confirmPasswordNode.unfocus();
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.00002)),
                      //* Don't have an account and forgot password texts...
                      HaveOrDontHaveAccountAndForgotPassTexts(
                        onAccountTextsTap: () {
                          Navigator.pop(context);
                        },
                        text: "Already have an account?",
                        text2: "Login",
                        isLoginScreen: false,
                        onRightTextTap: () {
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.00012)),
                      //* Button to submit...
                      SubmitButtonWidget(
                        buttonText: 'SignUp',
                        onPressed: () {},
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      const OrDividerWidget(),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Button to SignUp with Google...
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
      ),
    );
  }
}
