import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/simpleHeader.dart';

class PalettesScreen extends StatefulWidget {
  const PalettesScreen({super.key});

  @override
  State<PalettesScreen> createState() => _PalettesScreenState();
}

class _PalettesScreenState extends State<PalettesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(themeProvider).value;

          List colors = [
            AppPalette.lightColorPalette,
            AppPalette.darkColorPalette,
            AppPalette.pinkColorPalette,
            AppPalette.blueColorPalette,
            AppPalette.redColorPalette,
          ];

          return LayoutBuilder(
            builder: (context, constraints) {
              return Scaffold(
                backgroundColor: palette.backgroundColor,
                body: SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SimpleHeader(
                          constraints: constraints,
                          secondText: "paletas disponiveis no app!",
                          hasBackArrow: true,
                          headerTitle: "Paleta de Cores",
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth,
                              child: Column(
                                children: List.generate(colors.length, (index) {
                                  AppPalette palette = colors[index];

                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () => ref.read(themeProvider.notifier).selectTheme(
                                              index,
                                              context,
                                              'S',
                                            ),
                                        child: Container(
                                          height: 100,
                                          width: constraints.maxWidth * .9,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: palette.tileColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                  "#${palette.tileColor.value.toRadixString(16).substring(2, 8).toUpperCase()}",
                                                  style: TextStyle(
                                                    color: palette.titleColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
