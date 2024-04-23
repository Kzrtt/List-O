import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/simpleHeader.dart';

class AdvancedModeScreen extends StatefulWidget {
  const AdvancedModeScreen({super.key});

  @override
  State<AdvancedModeScreen> createState() => _AdvancedModeScreenState();
}

class _AdvancedModeScreenState extends State<AdvancedModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleHeader(
                          constraints: constraints,
                          text: "",
                          secondText: "Conheça o Modo Avançado do List-O",
                          menuTap: () {},
                          headerTitle: "Modo Avançado",
                          hasBackArrow: true,
                          hasSecondText: false,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Introdução",
                                style: TextStyle(
                                  color: palette.titleColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "O modo avançado do List-O consiste de uma adição de diversas novas funcionalidades planejadas para te auxiliar a manter uma rotina saudavel e se organizar melhor academicamene.",
                                style: TextStyle(
                                  color: palette.titleColor.withOpacity(.8),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Porque usar?",
                                style: TextStyle(
                                  color: palette.titleColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Caso você queira apenas fazer listas o modo básico é suficiente, porém ao usar o Modo Avançado que é 100% gratuito você consegue muito mais funcionalidades legais!",
                                style: TextStyle(
                                  color: palette.titleColor.withOpacity(.8),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 130),
                              ButtonWithIcon(
                                buttonText: "Ativar Modo Avançado",
                                height: 40,
                                width: constraints.maxWidth * .9,
                                borderRadius: 10,
                                onTap: () {},
                                icon: Icons.star,
                                iconSize: 22,
                              ),
                            ],
                          ),
                        )
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
