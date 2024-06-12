import 'package:flutter/material.dart';
import 'package:news_app/utils/my_media_query.dart';

class ProfileListTileWithToggle extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final void Function(bool) onChange;
  const ProfileListTileWithToggle({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00003)),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: getScreenArea(context, 0.00006)),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: getScreenArea(context, 0.00005),
                  ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
