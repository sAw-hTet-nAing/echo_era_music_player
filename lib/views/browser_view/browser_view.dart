import 'package:echo_era/core/theme/text_theme.dart';
import 'package:echo_era/core/utils/constants/app_config.dart';
import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:echo_era/core/widgets/app_textfield.dart';
import 'package:echo_era/data/local_data/top_sites_data.dart';
import 'package:echo_era/views/browser_view/borwser_widgets/top_site_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/browser_bloc.dart';

class BrowserView extends StatefulWidget {
  const BrowserView({super.key});

  @override
  State<BrowserView> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {
  final TextEditingController searchTextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppDimesions.normalGap),
        child: BlocBuilder<BrowserBloc, BrowserBlocState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConfig.appName,
                  style:
                      context.titleLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppConfig.appDescription,
                  style: context.labelMedium,
                ),
                SizedBox(
                  height: AppDimesions.largeGap,
                ),
                AppTextFieldWidget(
                  controller: searchTextcontroller,
                  hintText: "Search Websites",
                  prefixIcon: Icons.search,
                  onFieldSubmitted: (value) {},
                ),
                SizedBox(
                  height: AppDimesions.largeGap,
                ),
                Text(
                  "Top Sites",
                  style:
                      context.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: AppDimesions.normalGap,
                ),
                Wrap(
                  children: List.generate(
                      TopSites.topSites.length,
                      (index) => TopSitesWidget(
                          topSiteDataEntity: TopSites.topSites[index])),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
