import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/bloc/profile_screen_bloc/bloc/profile_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/widgets/full_screen_image.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_image_widget.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_list_tile_widget.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/screen_loading_widget.dart';
import 'package:news_app/widgets/try_again_widget.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});
  static const String id = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(firebaseUserInfoRepository)..add(ProfileScreenStarted(userId: userId)),
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
                      Stack(
                        children: [
                          //* Profile image avatar...
                          ProfileImageWidget(
                            userImage: state.userInfo['profileImage'],
                            onCameraTap: () {},
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: state.userInfo['profileImage'])),
                              );
                            },
                          ),
                          //* Camera icon to change profile image...
                          Positioned(
                            bottom: 0,
                            right: getScreenArea(context, 0.00008),
                            child: GestureDetector(
                              onTap: () async {
                                BlocProvider.of<ProfileBloc>(context).add(
                                  ProfileImageChangeIsClicked(
                                    userName: state.userInfo['name'],
                                    userId: state.userInfo['id'],
                                    previousImageUrl: state.userInfo['profileImage'],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(getScreenArea(context, 0.00002)),
                                decoration: BoxDecoration(
                                  color: kGreyColorShade300,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_enhance,
                                    size: getScreenArea(context, 0.00006),
                                    color: kGreyColorShade500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        title: 'Bookmarked News',
                        icon: Icons.bookmark_border_rounded,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: getScreenArea(context, 0.0001),
                      ),
                      //* Logout list tile...
                      ProfileListTileWidget(
                        title: 'LogOut',
                        icon: Icons.logout_rounded,
                        onTap: () {},
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
                      BlocProvider.of<ProfileBloc>(context).add(ProfileScreenRefresh(userId: userId));
                    },
                    buttonText: 'Try again');
              } else {
                //* Widget when state fails for any reason...
                return TryAgainWidget(
                  errorMessage: 'Screen does not respond at the moment, please try again later!',
                  onTryAgainPressed: () {
                    BlocProvider.of<ProfileBloc>(context).add(ProfileScreenRefresh(userId: userId));
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
