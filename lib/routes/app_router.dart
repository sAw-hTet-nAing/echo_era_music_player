import 'package:echo_era/views/main_view/main_view.dart';
import 'package:echo_era/views/player_view/player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../views/player_view/player_bloc/player_bloc.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const MainView();
          },
          routes: [
            GoRoute(
              name: "player",
              path: 'player',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) => PlayerBloc(state.extra as List<String>,
                      int.parse(state.uri.queryParameters['index'] as String)),
                  child: const PlayerView(),
                );
              },
            ),
          ]),
    ],
  );
}
