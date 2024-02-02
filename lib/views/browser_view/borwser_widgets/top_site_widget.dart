import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:echo_era/data/local_data/top_sites_data.dart';
import 'package:echo_era/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TopSitesWidget extends StatelessWidget {
  final TopSiteDataEntity topSiteDataEntity;
  const TopSitesWidget({super.key, required this.topSiteDataEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(AppRouteName.web,
          queryParameters: {"url": topSiteDataEntity.url}),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.circle),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(right: AppDimesions.width1 * 2),
        child: SvgPicture.asset(
          topSiteDataEntity.iconUrl,
          height: AppDimesions.largeIconSize,
          width: AppDimesions.largeIconSize,
        ),
      ),
    );
  }
}
