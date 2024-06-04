import 'package:flutter/material.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback onTap;
  const ProfileListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00008)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: getScreenArea(context, 0.00004)),
            Text(title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600, fontSize: getScreenArea(context, 0.00005))),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: getScreenArea(context, 0.00005)),
          ],
        ),
      ),
    );
  }
}
