import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/listProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/listTile.dart';
import 'package:prj_list_app/widgets/textForms.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class OldListScreen extends StatefulWidget {
  const OldListScreen({super.key});

  @override
  State<OldListScreen> createState() => _OldListScreenState();
}

class _OldListScreenState extends State<OldListScreen> {
  final addListFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(themeProvider).value;
          final listProvider = ref.watch(itemListProvider).value;

          showModal(AppPalette palette, ItemList listParam) {
            ItemList list = ItemList(alteredIn: DateTime.now(), finishedIn: DateTime.now());

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
            backgroundColor: palette.backgroundColor,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Header(
                        constraints: constraints,
                        text: "Listas Antigas",
                        secondText: UtilsMethods.capatalize(
                          UtilsMethods.getCorrectDate(
                            DateTime.now(),
                          ),
                        ),
                        menuTap: () => UtilsMethods.showOptionsModal(
                          context,
                          constraints,
                          palette,
                        ),
                        hasBackArrow: true,
                      ),
                      const SizedBox(height: 20),
                      listProvider.isNotEmpty && listProvider.any((element) => element.isFinished! && !UtilsMethods.isYesterdayOrToday(element.finishedIn))
                          ? Wrap(
                              children: [
                                SizedBox(
                                  child: Column(
                                    children: List.generate(
                                      listProvider.length,
                                      (index) {
                                        ItemList list = listProvider[index];
                                        return list.isFinished! && !UtilsMethods.isYesterdayOrToday(list.finishedIn)
                                            ? Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () => GoRouter.of(context).push('/listDetails/${list.itemId}'),
                                                    child: CustomListTile(
                                                      constraints: constraints,
                                                      list: list.name!,
                                                      details: list.details!,
                                                      isFinished: list.isFinished!,
                                                      text: "Finalizado em:",
                                                      alteredIn: DateFormat('dd/MM/yyyy').format(list.finishedIn),
                                                      delete: () => ref.read(itemListProvider.notifier).removeItem(
                                                            list.itemId,
                                                            context,
                                                          ),
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
