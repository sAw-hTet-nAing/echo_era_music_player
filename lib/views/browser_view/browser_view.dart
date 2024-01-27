import 'package:echo_era/core/theme/text_theme.dart';
import 'package:echo_era/core/utils/constants/app_config.dart';
import 'package:echo_era/core/utils/constants/app_dimesions.dart';
import 'package:echo_era/core/widgets/app_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/browser_bloc.dart';

class BrowserView extends StatefulWidget {
  const BrowserView({super.key});

  @override
  State<BrowserView> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {
  final TextEditingController searchTextcontroller = TextEditingController();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      preferredContentMode: UserPreferredContentMode.RECOMMENDED,
      javaScriptCanOpenWindowsAutomatically: true,
      forceDark: ForceDark.AUTO,
      transparentBackground: true,
      algorithmicDarkeningAllowed: true,
      javaScriptEnabled: true,
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.white,
      ),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          webViewController?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    searchTextcontroller.addListener(() {
      if (searchTextcontroller.text.isEmpty) {
        BlocProvider.of<BrowserBloc>(context)
            .add(const BrowserBlocEventOnSearch(isShowingWebView: false));
      }
    });
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
                  onFieldSubmitted: (value) {
                    var url = WebUri(value);
                    if (url.scheme.isEmpty) {
                      url = WebUri(
                          "https://www.youtube.com/results?search_query=$value");
                    }
                    webViewController!
                        .loadUrl(urlRequest: URLRequest(url: url));
                    BlocProvider.of<BrowserBloc>(context).add(
                        const BrowserBlocEventOnSearch(isShowingWebView: true));
                  },
                ),
                SizedBox(
                  height: AppDimesions.largeGap,
                ),

                Expanded(
                  child: InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: WebUri("https://www.youtube.com")),
                    initialSettings: settings,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onPermissionRequest: (controller, request) async {
                      return PermissionResponse(
                          resources: request.resources,
                          action: PermissionResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(uri)) {
                          // Launch the App
                          await launchUrl(
                            uri,
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController?.endRefreshing();
                      setState(() {
                        this.url = url.toString();
                        searchTextcontroller.text = this.url;
                      });
                    },
                    onReceivedError: (controller, request, error) {
                      pullToRefreshController?.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController?.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        searchTextcontroller.text = url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        this.url = url.toString();
                        searchTextcontroller.text = this.url;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      if (kDebugMode) {
                        print(consoleMessage);
                      }
                    },
                  ),
                ),

                // progress < 1.0
                //     ? LinearProgressIndicator(value: progress)
                //     : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
