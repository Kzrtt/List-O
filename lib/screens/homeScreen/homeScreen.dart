import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/listProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/listTile.dart';
import 'package:prj_list_app/widgets/miniButton.dart';
import 'package:prj_list_app/widgets/textForms.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final addListFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(themeProvider).value;
          final listProvider = ref.watch(itemListProvider).value;

          showModal(AppPalette palette, ItemList listParam) {
            ItemList list = ItemList(alteredIn: DateTime.now());

            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: 700,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: palette.titleColor.withOpacity(.8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: palette.tileColor,
                                size: 100,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listParam.name != "create" ? "Editar Lista: " : "Adicionar Lista :",
                                    style: TextStyle(
                                      color: palette.titleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Form(
                                    key: addListFormKey,
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          width: .95,
                                          constraints: constraints,
                                          hintText: "Nome da Lista",
                                          label: "Nome",
                                          initialValue: listParam.name == "create" ? "" : listParam.name,
                                          palette: palette,
                                          onSaved: (text) => list.name = text!,
                                          validator: (text) => Validator.validateNotEmpty(text),
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextFormField(
                                          width: .95,
                                          constraints: constraints,
                                          hintText: "Detalhes da Lista",
                                          label: "Detalhes",
                                          initialValue: listParam.details,
                                          palette: palette,
                                          onSaved: (text) => list.details = text!,
                                          validator: (text) => Validator.validateNotEmpty(text),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ButtonWithIcon(
                                        buttonText: "Voltar",
                                        height: 40,
                                        width: constraints.maxWidth * .4,
                                        borderRadius: 10,
                                        onTap: () => Navigator.of(context).pop(),
                                        icon: Icons.close,
                                        buttonColor: Colors.red.withOpacity(.5),
                                        iconColor: Colors.red,
                                        textColor: Colors.red,
                                      ),
                                      ButtonWithIcon(
                                        buttonText: listParam.name != "create" ? "Editar" : "Salvar",
                                        height: 40,
                                        width: constraints.maxWidth * .4,
                                        borderRadius: 10,
                                        onTap: () {
                                          if (addListFormKey.currentState!.validate()) {
                                            addListFormKey.currentState!.save();
                                            if (listParam.name == "create") {
                                              ref.read(itemListProvider.notifier).addItem(list);
                                            } else {
                                              list.alteredIn = DateTime.now();
                                              ref.read(itemListProvider.notifier).updateItem(listParam.itemId, list);
                                            }
                                            Navigator.of(context).pop();
                                          } else {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: "Erro ao Criar",
                                              text: "Preencha os campos corretamente...",
                                              disableBackBtn: true,
                                              onConfirmBtnTap: () => Navigator.of(context).pop(),
                                            );
                                          }
                                        },
                                        icon: Icons.save,
                                        buttonColor: palette.buttonColor.withOpacity(.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }

          return Scaffold(
            floatingActionButton: ButtonWithIcon(
              buttonText: "Adicionar",
              height: 40,
              width: 120,
              borderRadius: 10,
              onTap: () => showModal(palette, ItemList(name: "create", alteredIn: DateTime.now())),
              icon: Icons.add,
            ),
            backgroundColor: palette.backgroundColor,
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
                          secondText: UtilsMethods.capatalize(
                            UtilsMethods.getCorrectDate(
                              DateTime.now(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Suas Listas",
                                style: TextStyle(
                                  color: palette.titleColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              listProvider.isNotEmpty
                                  ? Wrap(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: List.generate(
                                              listProvider.length,
                                              (index) {
                                                ItemList list = listProvider[index];
                                                return !list.isFinished!
                                                    ? Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () => GoRouter.of(context).push('/listDetails/${list.itemId}'),
                                                            child: CustomListTile(
                                                              constraints: constraints,
                                                              list: list.name!,
                                                              details: list.details!,
                                                              isFinished: list.isFinished!,
                                                              alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                              delete: () => ref.read(itemListProvider.notifier).removeItem(list.itemId),
                                                              edit: () => showModal(palette, list),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                        ],
                                                      )
                                                    : const Center();
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 70),
                                      child: SizedBox(
                                        height: 250,
                                        width: constraints.maxWidth,
                                        child: SvgPicture.asset(
                                          palette.homePageImage!,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                              listProvider.any((element) => element.isFinished!)
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        const Divider(endIndent: 50, indent: 50),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Recentemente Finalizadas",
                                          style: TextStyle(
                                            color: AppPalette.disabledColor.titleColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Center(),
                              const SizedBox(height: 20),
                              listProvider.isNotEmpty
                                  ? Wrap(
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: List.generate(
                                              listProvider.length,
                                              (index) {
                                                ItemList list = listProvider[index];
                                                return list.isFinished!
                                                    ? Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () => GoRouter.of(context).push('/listDetails/${list.itemId}'),
                                                            child: CustomListTile(
                                                              constraints: constraints,
                                                              list: list.name!,
                                                              details: list.details!,
                                                              isFinished: list.isFinished!,
                                                              alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                              delete: () => ref.read(itemListProvider.notifier).removeItem(list.itemId),
                                                              edit: () => showModal(palette, list),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 20),
                                                        ],
                                                      )
                                                    : const Center();
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const Center(),
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
          );
        },
      ),
    );
  }
}
