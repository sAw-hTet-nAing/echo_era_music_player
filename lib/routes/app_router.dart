import 'package:echo_era/routes/route_name.dart';
import 'package:echo_era/views/browser_view/bloc/browser_bloc.dart';
import 'package:echo_era/views/browser_view/browser_view.dart';
import 'package:echo_era/views/library_view/library_view.dart';
import 'package:echo_era/views/main_view/main_view.dart';
import 'package:echo_era/views/player_view/player_view.dart';
import 'package:echo_era/views/setting_view/setting_view.dart';
import 'package:echo_era/views/web_view/web_view.dart';
import 'package:echo_era/views/web_view/webview_bloc/web_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../views/player_view/player_bloc/player_bloc.dart';

class AppRouter {
  static final _parentKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      navigatorKey: _parentKey,
      initialLocation: "/browser",
      routes: <StatefulShellRoute>[
        StatefulShellRoute.indexedStack(
            parentNavigatorKey: _parentKey,
            builder: (context, state, child) {
              return MainView(
                child: child,
              );
            },
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                    name: AppRouteName.browser,
                    path: '/browser',
                    builder: (BuildContext context, GoRouterState state) {
                      return BlocProvider(
                        create: (context) => BrowserBloc(),
                        child: const BrowserView(),
                      );
                    },
                    routes: [
                      GoRoute(
                        name: AppRouteName.web,
                        path: 'webView',
                        builder: (BuildContext context, GoRouterState state) {
                          return BlocProvider(
                            create: (context) => WebViewBloc(),
                            child: WebView(
                              url: state.uri.queryParameters['url'] as String,
                            ),
                          );
                        },
                      ),
                    ]),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    name: AppRouteName.library,
                    path: '/library',
                    builder: (BuildContext context, GoRouterState state) {
                      return const LibraryView();
                    },
                    routes: [
                      GoRoute(
                        name: AppRouteName.player,
                        path: 'player',
                        builder: (BuildContext context, GoRouterState state) {
                          return BlocProvider(
                            create: (context) => PlayerBloc(
                                state.extra as List<String>,
                                int.parse(state.uri.queryParameters['index']
                                    as String)),
                            child: const PlayerView(),
                          );
                        },
                      ),
                    ]),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  name: AppRouteName.setting,
                  path: '/setting',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SetttingView();
                  },
                ),
              ])
            ])
      ]);
}
