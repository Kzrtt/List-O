import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/listTile.dart';
import 'package:prj_list_app/widgets/miniButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ButtonWithIcon(
          buttonText: "Adicionar",
          height: 40,
          width: 120,
          borderRadius: 10,
          onTap: () {},
          icon: Icons.add,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Header(
                      constraints: constraints,
                      text: "Olá, Usuário",
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Suas Listas",
                            style: TextStyle(
                              color: LightColorPalette.titleColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...List.generate(
                            4,
                            (index) {
                              return Column(
                                children: [
                                  CustomListTile(
                                    constraints: constraints,
                                    list: "Nome da Lista",
                                    details: "Lista de Mercado",
                                    alteredIn: "Alterado em: 10/04/2024",
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
