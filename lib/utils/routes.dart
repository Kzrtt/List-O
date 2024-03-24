import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/screens/homeScreen/homeScreen.dart';
import 'package:prj_list_app/screens/listDetails/listDetailsScreen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
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
  ],
);
