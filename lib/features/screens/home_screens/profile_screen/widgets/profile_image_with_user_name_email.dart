import 'package:flutter/material.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/profile_screen/widgets/profile_image_widget.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/full_screen_image.dart';

class ProfileImageWithUserNameEmail extends StatelessWidget {
  final dynamic userInfo;
  final VoidCallback onPressed;
  const ProfileImageWithUserNameEmail({
    super.key,
    required this.userInfo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.07)),
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: FirebaseUserInfoDataSourceImp.imageNotifier,
            builder: (context, value, child) {
              return ProfileImageWidget(
                userImage: value,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: value)),
                  );
                },
              );
            },
          ),
          SizedBox(width: getScreenArea(context, 0.00004)),
          //* User name and email...
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* User name text...
                Text(
                  userInfo['name'],
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: getScreenArea(context, 0.000001)),
                //* Email text with user email...
                Text(
                  userInfo['email'],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: getScreenArea(context, 0.00003)),
          SizedBox(
            height: getScreenArea(context, 0.00012),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: const Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }
}
