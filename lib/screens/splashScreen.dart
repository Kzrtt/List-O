import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/controllers/listProvider.dart';
import 'package:prj_list_app/controllers/orientationProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/models/User.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';

import '../models/List.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => splash());
  }

  Future<void> splash() async {
    AppPreferences prefs = AppPreferences();
    await prefs.startPreferences();

    List<String> items = await prefs.getStringList(PrefsContants.itemList);
    List<ItemList> prefsItemList = items.map((e) => ItemList.fromJson(jsonDecode(e))).toList();
    String palette = await prefs.getStringItem(PrefsContants.preferredColor);
    String orientation = await prefs.getStringItem(PrefsContants.preferredOrientation);
    String userEmail = await prefs.getStringItem(PrefsContants.signedUser);
    for (var element in prefsItemList) {
      print(element.name);
    }

    await ref.read(userProvider.notifier).getUserByEmail(userEmail);

    print("palette: $palette");
    if (palette == "") {
      palette = "1";
    }
    ref.read(orientationProvider.notifier).setOrientation(orientation);
    ref.read(themeProvider.notifier).selectTheme(
          int.parse(palette),
          context,
          'N',
        );
    ref.read(itemListProvider.notifier).setItems(prefsItemList);

    if (userEmail != "") {
      ref.read(userProvider.notifier).getUserByEmail(userEmail);
      if (ref.watch(userProvider).value.isAdvanced) {
        Future.delayed(const Duration(seconds: 2)).then((value) => GoRouter.of(context).push('/advHomeScreen'));
      } else {
        Future.delayed(const Duration(seconds: 2)).then((value) => GoRouter.of(context).push('/homeScreen'));
      }
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) => GoRouter.of(context).push('/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userProvider).value;
          final palette = user.isAdvanced ? user.palette : ref.watch(themeProvider).value;

          return Scaffold(
            backgroundColor: palette!.backgroundColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (AppController.instance.isDebug) {
                            AppPreferences preferences = AppPreferences();
                            preferences.removeItem(PrefsContants.itemList);
                            preferences.removeItem(PrefsContants.preferredColor);
                            print("@#@#@#@#@##@#@");
                          }
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            color: palette.titleColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: palette.tileColor,
                              size: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
