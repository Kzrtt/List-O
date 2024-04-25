import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/widgets/editOptionTile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(userProvider).value;
        final palette = ref.watch(themeProvider).value;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: palette.backgroundColor,
              body: SafeArea(
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 190,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    color: palette.tileColor.withOpacity(.8),
                                  ),
                                  child: user.photo == ""
                                      ? Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Icon(
                                              Icons.account_circle,
                                              size: 130,
                                              color: palette.titleColor,
                                            )
                                          ],
                                        )
                                      : const Center(),
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: .1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 60,
                                  width: constraints.maxWidth * .9,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: UtilsMethods.getMixedColor(palette.titleColor.withOpacity(.9)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      user.name,
                                      style: TextStyle(
                                        color: palette.titleColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 20,
                              child: InkWell(
                                onTap: () => GoRouter.of(context).pop(),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: palette.titleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () => GoRouter.of(context).push("/oldLists"),
                          child: EditOptionButton(
                            constraints: constraints,
                            title: "Listas Antigas",
                            content: "Reveja suas listas antigas",
                            icon: Icons.history_outlined,
                            color: palette.titleColor,
                            iconColor: palette.tileColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            AppPreferences prefs = AppPreferences();
                            prefs.removeItem(PrefsContants.itemList);
                            prefs.removeItem(PrefsContants.preferredColor);
                            GoRouter.of(context).pushReplacementNamed('/homeScreen');
                          },
                          child: EditOptionButton(
                            constraints: constraints,
                            title: "Limpar Listas",
                            content: "Isso fará você perder as listas",
                            icon: Icons.delete_forever_outlined,
                            color: palette.titleColor,
                            iconColor: palette.tileColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => GoRouter.of(context).push("/palettes"),
                          child: EditOptionButton(
                            constraints: constraints,
                            title: "Paletas de Cores",
                            content: "Alterne entre os temas disponiveis no App",
                            icon: Icons.palette_outlined,
                            color: palette.titleColor,
                            iconColor: palette.tileColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => GoRouter.of(context).push("/advancedMode"),
                          child: EditOptionButton(
                            constraints: constraints,
                            title: "Modo Avançado",
                            content: "Entenda oque é o modo avançado",
                            icon: Icons.star_outline,
                            color: palette.titleColor,
                            iconColor: palette.tileColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            ref.read(userProvider.notifier).logout();

                            GoRouter.of(context).pushReplacement("/");
                          },
                          child: EditOptionButton(
                            constraints: constraints,
                            title: "Loggout",
                            content: "Sair da sua conta :(",
                            icon: Icons.logout,
                            color: AppPalette.redColorPalette.titleColor,
                            iconColor: AppPalette.redColorPalette.tileColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
