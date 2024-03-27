import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';

class SelectColor extends StatelessWidget {
  const SelectColor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Definindo a cor de fundo da página como semi-transparente
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            List colors = [
              AppPalette.lightColorPalette,
              AppPalette.darkColorPalette,
              AppPalette.pinkColorPalette,
              AppPalette.blueColorPalette,
              AppPalette.redColorPalette,
            ];

            final themePalette = ref.watch(themeProvider).value;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 140,
                        width: constraints.maxWidth * .95,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Selecione a Cor",
                              style: TextStyle(
                                color: themePalette.titleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                colors.length,
                                (index) {
                                  AppPalette palette = colors[index];

                                  return InkWell(
                                    onTap: () => ref.read(themeProvider.notifier).selectTheme(
                                          index,
                                          context,
                                          'S',
                                        ),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        color: palette.titleColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
    ;
  }
}
