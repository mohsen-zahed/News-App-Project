import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/bloc/profile_screen_bloc/bloc/profile_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_image_with_user_name_email.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_list_tile_with_toggle.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/reading_list_screen.dart';
import 'package:news_app/features/screens/initial_screens/registration_screen/login_screen/login_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_constants.dart';
import 'package:news_app/packages/shared_preferences_package/shared_preferences_package.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_list_tile_widget.dart';
import 'package:news_app/theme/theme_provider.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/screen_loading_widget.dart';
import 'package:news_app/widgets/try_again_widget.dart';
import 'package:provider/provider.dart';

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
    bool isDarkMode = !helperFunctions.isThemeLightMode(context);
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
                      //* Profile image with user name and email...
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, innerState) {
                          return ProfileImageWithUserNameEmail(
                            userInfo: state.userInfo,
                            onPressed: () {
                              BlocProvider.of<ProfileBloc>(context).add(
                                ProfileImageChangeIsClicked(
                                  userName: state.userInfo['name'],
                                  userId: state.userInfo['id'],
                                  previousImageUrl: state.userInfo['profileImage'],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: getScreenArea(context, 0.00009)),
                      //* Settings...
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00008)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Settings', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade400)),
                            SizedBox(height: getScreenArea(context, 0.00002)),
                            ProfileListTileWithToggle(
                              title: 'Dark mode',
                              icon: CupertinoIcons.moon,
                              value: isDarkMode,
                              onChange: (value) {
                                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                              },
                            ),
                            SizedBox(height: getScreenArea(context, 0.00001)),
                            ProfileListTileWithToggle(
                              title: 'Notifications',
                              icon: Icons.notifications_none_rounded,
                              value: isDarkMode,
                              onChange: (value) {},
                            ),
                            SizedBox(height: getScreenArea(context, 0.000035)),
                            ProfileListTileWidget(
                              title: 'Reading list',
                              icon: Icons.bookmark_border_rounded,
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => const ReadingListScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.00009)),
                      //* Summary...
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00008)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Summary', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade400)),
                            SizedBox(height: getScreenArea(context, 0.00002)),
                            ProfileListTileWithToggle(
                              title: 'News by location',
                              icon: CupertinoIcons.location,
                              value: isDarkMode,
                              onChange: (value) {},
                            ),
                            SizedBox(height: getScreenArea(context, 0.000035)),
                            ProfileListTileWidget(
                              title: 'Time to read',
                              icon: Icons.access_time,
                              onTap: () {},
                            ),
                            SizedBox(height: getScreenArea(context, 0.00007)),
                            ProfileListTileWidget(
                              title: 'Language',
                              icon: Icons.language,
                              onTap: () {},
                            ),
                            SizedBox(height: getScreenArea(context, 0.00007)),
                            ProfileListTileWidget(
                              title: 'Block content and sources',
                              icon: Icons.block,
                              onTap: () {},
                            ),
                            SizedBox(height: getScreenArea(context, 0.00007)),
                            ProfileListTileWidget(
                              title: 'Help',
                              icon: Icons.help_outline_rounded,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.00009)),
                      //* Account settings...
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00008)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Account', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade400)),
                            SizedBox(height: getScreenArea(context, 0.00003)),
                            //* Logout list tile...
                            ProfileListTileWidget(
                              title: 'Log Out',
                              icon: Icons.logout_rounded,
                              titleColor: kRedColor,
                              onTap: () {
                                helperFunctions.showConfirmationDialogBox(
                                  context,
                                  'Signing Off Safely?',
                                  titleText: 'Logging Out',
                                  onConfirm: () {
                                    BlocProvider.of<ProfileBloc>(context).add(SignOutButtonIsClicked());
                                  },
                                  onCancel: () {},
                                );
                              },
                            ),
                          ],
                        ),
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
