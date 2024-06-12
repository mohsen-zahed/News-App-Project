import 'package:flutter/material.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback onTap;
  final Color? titleColor;
  const ProfileListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00003)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: titleColor),
            SizedBox(width: getScreenArea(context, 0.00006)),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: getScreenArea(context, 0.00005),
                    ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: titleColor, size: getScreenArea(context, 0.00005)),
          ],
        ),
      ),
    );
  }
}
