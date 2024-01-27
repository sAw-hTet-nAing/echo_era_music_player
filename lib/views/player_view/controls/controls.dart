import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final double? size;
  const ControlButtons(
      {super.key, this.onPressed, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: size ?? AppDimesions.normalIconSize,
        ));
  }
}
