import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';
import 'package:news_app/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/have_or_dont_have_account_and_forgot_pass_texts.dart.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/google_login_button.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/or_divider_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/submit_button_widget.dart';
import 'package:news_app/features/bloc/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
import 'package:news_app/utils/my_media_query.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/sign_up_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  SignUpBloc? signUpBloc;
  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    signUpBloc?.close();
    streamSubscription?.cancel();
  }

  bool obsecurePass = true;
  bool obsecureConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) {
        signUpBloc = SignUpBloc(firebaseAuthRepository);
        streamSubscription = signUpBloc?.stream.listen((state) async {
          if (state is SignUpFailed) {
            helperFunctions.showSnackBar(context, state.errorMessage, 5500);
          } else if (state is SignUpSuccess) {
            helperFunctions.showRapidSnackBar(context, "You've been registered as ${state.userCredential.user!.email}");
            await MySharedPreferencesPackage.instance
                .storeUserInfoAndRegistrationToLocale(userInfoKey, state.userCredential, isRegisteredKey, true)
                .then((value) {
              Future.delayed(const Duration(seconds: 2)).then((value) {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false, arguments: {'userCredential': value});
              });
            }).onError((error, stackTrace) {
              helperFunctions.showRapidSnackBar(context, error.toString());
            });
          }
        });
        return signUpBloc!;
      },
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
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getScreenArea(context, 0.0001)),
                          //* TETCO NEWS image...
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(getScreenArea(context, 0.00008)),
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
                          SizedBox(height: getScreenArea(context, 0.0001)),
                          //* Registration text...
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
                            child: Text(
                              'SignUp before continuing to application!',
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: getScreenArea(context, 0.00005)),
                          //* Name field...
                          RegistrationTextFieldWidget(
                            textInputType: TextInputType.text,
                            hintText: 'Name *',
                            prefixIcon: Icons.person,
                            controller: _nameController,
                            focusNode: _nameNode,
                            onSumbit: (value) {
                              // _emailNode.requestFocus(_passwordNode);
                            },
                          ),
                          SizedBox(height: getScreenArea(context, 0.00005)),
                          //* Email field...
                          RegistrationTextFieldWidget(
                            textInputType: TextInputType.emailAddress,
                            hintText: 'Email address *',
                            prefixIcon: Icons.email,
                            controller: _emailController,
                            focusNode: _emailNode,
                            onSumbit: (value) {
                              // _emailNode.requestFocus(_passwordNode);
                            },
                          ),
                          SizedBox(height: getScreenArea(context, 0.00005)),
                          //* Password field...
                          RegistrationTextFieldWidget(
                            onShowPasswordTap: () {
                              setState(() {
                                obsecurePass = !obsecurePass;
                              });
                            },
                            hintText: 'Password *',
                            prefixIcon: Icons.lock,
                            controller: _passwordController,
                            suffixIcon: obsecurePass ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                            isObsecured: obsecurePass,
                            focusNode: _passwordNode,
                            onSumbit: (value) {
                              // _emailNode.requestFocus(_confirmPasswordNode);
                            },
                          ),
                          SizedBox(height: getScreenArea(context, 0.00005)),
                          //* Confirm password field...
                          RegistrationTextFieldWidget(
                            onShowPasswordTap: () {
                              setState(() {
                                obsecureConfirmPass = !obsecureConfirmPass;
                              });
                            },
                            hintText: 'Confirm password *',
                            prefixIcon: Icons.lock,
                            controller: _confirmPasswordController,
                            suffixIcon: obsecureConfirmPass ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                            isObsecured: obsecureConfirmPass,
                            focusNode: _confirmPasswordNode,
                            onSumbit: (value) {
                              // _confirmPasswordNode.unfocus();
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
                              _emailController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                            },
                          ),
                          SizedBox(height: getScreenArea(context, 0.0001)),
                          //* Button to submit...
                          BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (previous, current) {
                              return current is SignUpLoading;
                            },
                            builder: (context, state) {
                              bool isSubmitting = state is! SignUpLoading ? true : false;
                              return SubmitButtonWidget(
                                isLoading: isSubmitting,
                                buttonText: 'SignUp',
                                onPressed: () async {
                                  setState(() {
                                    isSubmitting = true;
                                  });
                                  String name = _nameController.text.trim();
                                  String email = _emailController.text.trim();
                                  String password = _passwordController.text.trim();
                                  String confirmPassword = _confirmPasswordController.text.trim();
                                  if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
                                    if (password == confirmPassword) {
                                      BlocProvider.of<SignUpBloc>(context).add(SignUpButtonIsClicked(
                                        name: name,
                                        email: email,
                                        password: password,
                                      ));
                                    } else {
                                      helperFunctions.showSnackBar(context, 'Confirm password should be the same as your password!', 5500);
                                    }
                                  } else {
                                    helperFunctions.showSnackBar(context, 'Please fill the required fields!', 5500);
                                  }

                                  setState(() {
                                    isSubmitting = false;
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(height: getScreenArea(context, 0.00004)),
                          const OrDividerWidget(),
                          SizedBox(height: getScreenArea(context, 0.00004)),
                          //* Button to SignUp with Google...
                          GoogleLoginButton(
                            onButtonTap: () {},
                          ),
                        ],
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
