import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  final StatefulNavigationShell child;
  const MainView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        onTap: (value) => child.goBranch(value),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.globe,
              size: AppDimesions.normalIconSize,
            ),
            label: 'Browser',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
              size: AppDimesions.normalIconSize,
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
              size: AppDimesions.normalIconSize,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
