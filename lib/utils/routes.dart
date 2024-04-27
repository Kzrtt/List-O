import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/advancedModeScreens/advListDetailsScreen/advListDetailsScreen.dart';
import 'package:prj_list_app/advancedModeScreens/advModeHomeScreen/advHomeScreen.dart';
import 'package:prj_list_app/screens/advancedModeScreen/advancedModeScreen.dart';
import 'package:prj_list_app/screens/homeScreen/homeScreen.dart';
import 'package:prj_list_app/screens/listDetailsScreen/listDetailsScreen.dart';
import 'package:prj_list_app/screens/loginScreen/loginScreen.dart';
import 'package:prj_list_app/screens/oldListScreen/oldListsScreen.dart';
import 'package:prj_list_app/screens/palettesScreen/palettesScreen.dart';
import 'package:prj_list_app/advancedModeScreens/profileScreen/profileScreen.dart';
import 'package:prj_list_app/screens/signUpScreen/signUpScreen.dart';
import 'package:prj_list_app/screens/splashScreen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    //? base mode routes
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
    GoRoute(
      path: '/advancedMode',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: AdvancedModeScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: LoginScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/signUp',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: SignUpScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    //? advancedMode routes
    GoRoute(
      path: '/advHomeScreen',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: AdvHomeScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/profileScreen',
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: ProfileScreen(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: "/advListDetails/:listId",
      pageBuilder: (context, state) {
        final listId = state.pathParameters['listId'];

        return MaterialPage(
          child: AdvListDetailsScreen(
            listId: listId!,
          ),
          fullscreenDialog: true,
        );
      },
    ),
  ],
);
