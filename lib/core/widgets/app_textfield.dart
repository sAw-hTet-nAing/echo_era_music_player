import 'package:echo_era/core/theme/text_theme.dart';
import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Function(String)? onFieldSubmitted;
  const AppTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onFieldSubmitted,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: context.labelMedium,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimesions.normalGap,
              vertical: AppDimesions.normalGap),
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            size: AppDimesions.normalIconSize,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
