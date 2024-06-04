import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/screens/home_screens/news_details_screen/widgets/full_screen_image.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_list_tile_widget.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  const ProfileScreen({super.key, required this.userInfo});
  static const String id = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getScreenArea(context, 0.00006),
              ),
              ProfileImageWidget(
                userImage: userInfo['profileImage'],
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => FullScreenImage(imageUrl: userInfo['profileImage'])),
                  );
                },
              ),
              SizedBox(
                height: getScreenArea(context, 0.00006),
              ),
              Text(
                userInfo['name'],
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              ),
              SizedBox(
                height: getScreenArea(context, 0.00001),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('E-mail: ', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    userInfo['email'],
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400, decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: getScreenArea(context, 0.00015),
              ),
              ProfileListTileWidget(
                title: 'Bookmarked News',
                icon: Icons.bookmark_border_rounded,
                onTap: () {},
              ),
              SizedBox(
                height: getScreenArea(context, 0.0001),
              ),
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
        ),
      ),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.userImage,
    required this.onTap,
  });

  final GestureTapCallback onTap;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: getScreenArea(context, 0.0005),
            padding: EdgeInsets.all(getScreenArea(context, 0.000005)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: kSecondaryColor,
                width: 3,
              ),
            ),
            child: CustomCachedNetworkImage(borderRadius: 100, imageUrl: userImage),
          ),
          Positioned(
            bottom: 0,
            right: getScreenArea(context, 0.00008),
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
        ],
      ),
    );
  }
}
