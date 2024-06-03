import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/data/repository/ifirebase_auth_repository.dart';
import 'package:news_app/features/bloc/forgot_password_bloc/bloc/forgot_password_bloc.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/registration_text_field_widget.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/widgets/submit_button_widget.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = '/forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();

  ForgotPasswordBloc? forgotPasswordBloc;
  StreamSubscription? forgotPassStreamSubscription;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailNode.dispose();
    forgotPasswordBloc?.close();
    forgotPassStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) {
        forgotPasswordBloc = ForgotPasswordBloc(firebaseAuthRepository);
        forgotPassStreamSubscription = forgotPasswordBloc?.stream.listen((state) async {
          if (state is ForgotPasswordSentSuccess) {
            await Future.delayed(const Duration(seconds: 2)).then((value) {
              helperFunctions.showSnackBar(context, 'link sent to your email', 3000);
            });
          } else if (state is ForgotPasswordSentFailed) {
            helperFunctions.showSnackBar(context, state.errorMessage, 3000);
          }
        });
        return forgotPasswordBloc!;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: getMediaQueryWidth(context),
            height: getMediaQueryHeight(context),
            decoration: const BoxDecoration(
              color: kBlackColor,
              image: DecorationImage(
                image: AssetImage(onboardingBackground2Path),
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
                          'Please enter an active email address to receive the password reset link!',
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: kWhiteColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.00005)),
                      RegistrationTextFieldWidget(
                        hintText: 'Email address *',
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        controller: _emailController,
                        focusNode: _emailNode,
                        onSumbit: (value) {},
                      ),
                      SizedBox(height: getScreenArea(context, 0.0003)),
                      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        builder: (context, state) {
                          return SubmitButtonWidget(
                            isLoading: state is ForgotPasswordLoading,
                            buttonText: 'Send',
                            onPressed: () async {
                              String email = _emailController.text.trim();
                              if (email.isNotEmpty) {
                                BlocProvider.of<ForgotPasswordBloc>(context).add(ForgotPasswordButtonIsClicked(email: email));
                              } else {
                                helperFunctions.showSnackBar(context, 'Please enter an email address to receive reset link!', 3000);
                              }
                            },
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
