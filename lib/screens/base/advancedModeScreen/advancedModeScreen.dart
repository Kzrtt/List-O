import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/screens/base/advancedModeScreen/Page01.dart';
import 'package:prj_list_app/screens/base/advancedModeScreen/Page02.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/simpleHeader.dart';

class AdvancedModeScreen extends StatefulWidget {
  const AdvancedModeScreen({super.key});

  @override
  State<AdvancedModeScreen> createState() => _AdvancedModeScreenState();
}

class _AdvancedModeScreenState extends State<AdvancedModeScreen> {
  final controller = PageController(initialPage: 0);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(userProvider).value;
        final palette = user.isAdvanced ? user.palette : ref.watch(themeProvider).value;

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: palette!.backgroundColor,
              body: SafeArea(
                child: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SimpleHeader(
                        constraints: constraints,
                        secondText: "Conheça o Modo Avançado do List-O",
                        headerTitle: "Modo Avançado",
                        hasBackArrow: true,
                        hasSecondText: false,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: PageView(
                          onPageChanged: (value) {
                            setState(() {
                              index = value;
                            });
                          },
                          children: [
                            Page01(constraints: constraints),
                            Page02(constraints: constraints),
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Troque o Modo!",
                                      style: TextStyle(
                                        color: palette.titleColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Mude o modo do seu app para avançado para ter uma melhor experiência",
                                        style: TextStyle(
                                          color: palette.titleColor.withOpacity(.8),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: SizedBox(
                                        height: 200,
                                        width: constraints.maxWidth,
                                        child: SvgPicture.asset(
                                          "assets/undraw_showing_support_re_5f2v.svg",
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                          colorFilter: ColorFilter.mode(palette.titleColor, BlendMode.modulate),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 80),
                                    ButtonWithIcon(
                                      buttonText: "Ativar Modo Avançado",
                                      height: 40,
                                      width: constraints.maxWidth * .9,
                                      borderRadius: 10,
                                      onTap: () {
                                        if (user.name == "") {
                                          GoRouter.of(context).push('/signUp');
                                        } else {
                                          ref.read(userProvider.notifier).convertToAdvanced(user);
                                          GoRouter.of(context).pushReplacement('/');
                                        }
                                      },
                                      icon: Icons.star,
                                      iconSize: 22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          3,
                          (listIndex) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: listIndex == index ? palette.titleColor : AppPalette.disabledColor.titleColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
