import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/screens/home_screens/home_screen/home_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/have_or_dont_have_account_and_forgot_pass_texts.dart.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/submit_button_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/sign_up_screen.dart/sign_up_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
import 'package:news_app/utils/my_media_query.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'amirehsanzahedi@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '12344321');
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  LoginBloc? loginBloc;
  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    loginBloc?.close();
    streamSubscription?.cancel();
  }

  bool showPassword = false;
  bool isStored = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        loginBloc = LoginBloc(firebaseUserInfoRepository);
        //* Here I am listening to state in order to show snackbar and navigate user to next screen....
        //* Because user can login with email or anonymously
        //* we have two sections, one for loging in with email and another one for anonymous login...
        //* Starts here...
        streamSubscription = loginBloc?.stream.listen((state) async {
          if (state is LoginSuccess) {
            helperFunctions.showSnackBar(context, 'Your are logged in as ${state.userCredential.user!.email}', 4000);
            await MySharedPreferencesPackage.instance
                .storeUserInfoAndRegistrationToLocale(userInfoKey, state.documentSnapshot, isRegisteredKey, true)
                .then((value) async {
              await Future.delayed(const Duration(seconds: 2)).then((value) {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false, arguments: {
                  'userData': state.documentSnapshot,
                });
              });
            }).onError((error, stackTrace) {
              helperFunctions.showSnackBar(context, error.toString(), 4000);
            });
          } else if (state is LoginAnonymouslySuccess) {
            helperFunctions.showSnackBar(context, 'Your are logged in Anonymously!', 4000);
            await MySharedPreferencesPackage.instance
                .storeUserInfoAndRegistrationToLocale(userInfoKey, state.documentSnapshot, isRegisteredKey, true)
                .then((value) async {
              await Future.delayed(const Duration(seconds: 2)).then((value) {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false, arguments: {
                  'userData': state.documentSnapshot,
                });
              });
            }).onError((error, stackTrace) {
              helperFunctions.showSnackBar(context, error.toString(), 4000);
            });
          } else if (state is LoginAnonymouslyFailed) {
            helperFunctions.showSnackBar(context, state.errorMessage, 5500);
          } else if (state is LoginFailed) {
            helperFunctions.showSnackBar(context, state.errorMessage, 5500);
          }
          //* Ends here...
        });
        return loginBloc!;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          //* Container containing entire screen with image on background...
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
              //* Blur effect...
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getScreenArea(context, 0.0002)),
                      //* App logo icon...
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
                      //* Guidance text to login...
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.08)),
                        child: Text(
                          'Login/SignUp to perceed to application!',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Email text field...
                      RegistrationTextFieldWidget(
                        hintText: 'Username or email *',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        controller: _emailController,
                        focusNode: _emailNode,
                        onSumbit: (value) {},
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      //* Password text field...
                      RegistrationTextFieldWidget(
                        onShowPasswordTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        hintText: 'Password *',
                        prefixIcon: Icons.lock,
                        controller: _passwordController,
                        focusNode: _passwordNode,
                        onSumbit: (value) {},
                        suffixIcon: showPassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash,
                        isObsecured: showPassword,
                      ),
                      SizedBox(height: getScreenArea(context, 0.00002)),
                      //* Switch between login/sign-up text...
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
                        onRightTextTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ));
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.0003)),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          //* Button to submit form...
                          return SubmitButtonWidget(
                            isLoading: state is LoginLoading ? true : false,
                            buttonText: 'Login',
                            onPressed: () async {
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              if (email.isNotEmpty && password.isNotEmpty) {
                                BlocProvider.of<LoginBloc>(context).add(LoginButtonIsClicked(email: email, password: password));
                              } else {
                                helperFunctions.showSnackBar(context, 'Please fill the required fields!', 5500);
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.000095)),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<LoginBloc>(context).add(LoginAnonymouslyIsClicked());
                              },
                              //* Anonymous login text...
                              child: Text(
                                'Continue Anonymously',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: kWhiteColor,
                                      decorationColor: kWhiteColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
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
