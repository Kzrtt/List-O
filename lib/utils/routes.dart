import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/screens/homeScreen/homeScreen.dart';
import 'package:prj_list_app/screens/listDetailsScreen/listDetailsScreen.dart';
import 'package:prj_list_app/screens/oldListScreen/oldListsScreen.dart';
import 'package:prj_list_app/screens/palettesScreen/palettesScreen.dart';
import 'package:prj_list_app/screens/splashScreen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/homeScreen",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: "/listDetails/:listId",
      pageBuilder: (context, state) {
        final listId = state.pathParameters['listId'];

        return MaterialPage(
          child: ListDetailsScreen(
            listId: listId!,
          ),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: "/oldLists",
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: OldListScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/palettes',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: PalettesScreen(),
          fullscreenDialog: true,
        );
      },
    ),
  ],
);
