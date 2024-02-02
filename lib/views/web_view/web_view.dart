import 'package:echo_era/core/theme/text_theme.dart';
import 'package:echo_era/core/utils/constants/app_config.dart';
import 'package:echo_era/core/widgets/custom_icon_button.dart';
import 'package:echo_era/views/web_view/webview_bloc/web_view_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
            onPress: () => context.pop(),
            icon: Icons.arrow_back_ios_new_rounded),
        centerTitle: false,
        title: Text(
          AppConfig.appName,
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<WebViewBloc, WebViewState>(builder: (context, state) {
        if (state is WebViewError) {
          return Text(state.message);
        } else if (state is WebViewLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(
              value: state.progress,
              backgroundColor: Colors.white,
            ),
          );
        } else {
          return InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
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
            shouldOverrideUrlLoading: (controller, navigationAction) async {
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
            onLoadStart: (controller, url) {},
            onLoadStop: (controller, url) async {
              pullToRefreshController?.endRefreshing();
              setState(() {
                this.url = url.toString();
                // searchTextcontroller.text = this.url;
              });
            },
            onReceivedError: (controller, request, error) {
              print("Error ${error}");
              pullToRefreshController?.endRefreshing();
              context
                  .read<WebViewBloc>()
                  .add(WebViewEventOnError(errorMessage: error.toString()));
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController?.endRefreshing();
              }

              setState(() {
                this.progress = progress / 100;
              });
            },
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {
                print(consoleMessage);
              }
            },
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    webViewController?.dispose();

    super.dispose();
  }
}
