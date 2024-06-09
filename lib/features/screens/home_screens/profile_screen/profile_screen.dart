import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bloc/profile_screen_bloc/bloc/profile_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/reading_list_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/login_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
import 'package:news_app/widgets/full_screen_image.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_image_widget.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_list_tile_widget.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/screen_loading_widget.dart';
import 'package:news_app/widgets/try_again_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});
  static const String id = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc? _bloc;
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    super.dispose();
    _bloc?.close();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) {
        _bloc = ProfileBloc(firebaseUserInfoRepository)..add(ProfileScreenStarted(userId: widget.userId));
        _streamSubscription = _bloc?.stream.listen((state) async {
          if (state is ProfileSignOutSuccess) {
            await Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
              await MySharedPreferencesPackage.instance.clearSharedPreferencesByKey(userInfoKey);
              await MySharedPreferencesPackage.instance.clearSharedPreferencesByKey(isRegisteredKey).then((value) {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
                helperFunctions.showSnackBar(context, "You've been logged out!", 2000);
              });
            });
          } else if (state is ProfileSignOutFailed) {
            helperFunctions.showSnackBar(context, state.errorMessage, 2000);
          }
        });
        return _bloc!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileScreenLoading) {
                return const ScreenLoadingWidget(
                  loadingText: 'Loading profile...',
                );
              } else if (state is ProfileScreenSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: getScreenArea(context, 0.00006)),
                      ValueListenableBuilder(
                        valueListenable: FirebaseUserInfoDataSourceImp.imageNotifier,
                        builder: (context, value, child) => ProfileImageWidget(
                          userImage: value,
                          onCameraTap: () async {
                            BlocProvider.of<ProfileBloc>(context).add(
                              ProfileImageChangeIsClicked(
                                userName: state.userInfo['name'],
                                userId: state.userInfo['id'],
                                previousImageUrl: state.userInfo['profileImage'],
                              ),
                            );
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: value)),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.00006),
                      ),
                      //* User name text...
                      Text(
                        state.userInfo['name'],
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.00001),
                      ),
                      //* Email text with user email...
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('E-mail: ', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                          Text(
                            state.userInfo['email'],
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400, decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.00015),
                      ),
                      //* Bookmark list tile...
                      ProfileListTileWidget(
                        title: 'Reading list',
                        icon: Icons.bookmark_border_rounded,
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const ReadingListScreen()));
                        },
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.0001),
                      ),
                      //* Logout list tile...
                      ProfileListTileWidget(
                        title: 'Log Out',
                        icon: Icons.logout_rounded,
                        onTap: () {
                          BlocProvider.of<ProfileBloc>(context).add(SignOutButtonIsClicked());
                        },
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.00015),
                      ),
                    ],
                  ),
                );
              } else if (state is ProfileScreenFailed) {
                //* Widget when state fails...
                return TryAgainWidget(
                    errorMessage: state.errorMessage,
                    onTryAgainPressed: () {
                      BlocProvider.of<ProfileBloc>(context).add(ProfileScreenRefresh(userId: widget.userId));
                    },
                    buttonText: 'Try again');
              } else {
                //* Widget when state fails for any reason...
                return TryAgainWidget(
                  errorMessage: 'Screen does not respond at the moment, please try again later!',
                  onTryAgainPressed: () {
                    BlocProvider.of<ProfileBloc>(context).add(ProfileScreenRefresh(userId: widget.userId));
                  },
                  buttonText: 'Try again',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
