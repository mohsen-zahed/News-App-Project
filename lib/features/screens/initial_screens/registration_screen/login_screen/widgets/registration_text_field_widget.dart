import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/utils/my_media_query.dart';

class RegistrationTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final Color? backgroundColor;
  final IconData? suffixIcon;
  final bool? isObsecured;
  final GestureTapCallback? onShowPasswordTap;
  final FocusNode focusNode;
  final Function(String) onSumbit;
  final TextInputType? textInputType;
  const RegistrationTextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.backgroundColor,
    this.suffixIcon,
    this.isObsecured,
    this.onShowPasswordTap,
    required this.focusNode,
    required this.onSumbit,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenArea(context, 0.00015),
      margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.07)),
      padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.01)),
      decoration: BoxDecoration(
        color: backgroundColor ?? kGreyColorShade100Op2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          keyboardType: textInputType ?? TextInputType.text,
          onSubmitted: onSumbit,
          focusNode: focusNode,
          controller: controller,
          obscureText: isObsecured ?? false,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
            prefixIcon: Icon(prefixIcon, color: kGreyColorShade100Op2),
            suffixIcon: GestureDetector(
              onTap: onShowPasswordTap,
              child: Icon(suffixIcon, color: kGreyColorShade100Op2),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: hintText,
          ),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kGreyColorShade200),
        ),
      ),
    );
  }
}
