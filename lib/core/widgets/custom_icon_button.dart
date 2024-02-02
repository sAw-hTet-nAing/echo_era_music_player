import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() onPress;
  final IconData icon;
  final Color? color;
  const CustomIconButton(
      {super.key, required this.onPress, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        color: color ?? Colors.white,
        size: AppDimesions.normalIconSize,
      ),
    );
  }
}
