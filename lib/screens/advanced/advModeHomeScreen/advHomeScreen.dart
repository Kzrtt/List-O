import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/listProvider.dart';
import 'package:prj_list_app/controllers/orientationProvider.dart';
import 'package:prj_list_app/controllers/themeProvider.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/models/List.dart';
import 'package:prj_list_app/utils/AppController.dart';
import 'package:prj_list_app/utils/utilsMethods.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/gridTile.dart';
import 'package:prj_list_app/widgets/header.dart';
import 'package:prj_list_app/widgets/listTile.dart';
import 'package:prj_list_app/widgets/miniButton.dart';
import 'package:prj_list_app/widgets/textForms.dart';
import 'package:quickalert/quickalert.dart';

class AdvHomeScreen extends StatefulWidget {
  const AdvHomeScreen({super.key});

  @override
  State<AdvHomeScreen> createState() => _AdvHomeScreenState();
}

class _AdvHomeScreenState extends State<AdvHomeScreen> {
  final addListFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, ref, child) {
          final palette = ref.watch(userProvider).value.palette;
          final orientation = ref.watch(userProvider).value.orientation;
          final listProvider = ref.watch(userProvider).value.itemList;
          final user = ref.watch(userProvider).value;

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
                                              ref.read(userProvider.notifier).addList(list);
                                            } else {
                                              list.alteredIn = DateTime.now();
                                              ref.read(userProvider.notifier).updateList(listParam.itemId, list);
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
              onTap: () => showModal(palette!, ItemList(name: "create", alteredIn: DateTime.now(), finishedIn: DateTime.now())),
              icon: Icons.add,
            ),
            backgroundColor: palette!.backgroundColor,
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
                          text: "Olá, ${user.name == "" ? "Visitante" : user.name}",
                          secondText: UtilsMethods.capatalize(
                            UtilsMethods.getCorrectDate(
                              DateTime.now(),
                            ),
                          ),
                          menuTap: () => GoRouter.of(context).push('/profileScreen'),
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
                              listProvider.isNotEmpty && listProvider.any((element) => element.isFinished != true)
                                  ? orientation == "list"
                                      ? Wrap(
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(minHeight: 100),
                                              child: Column(
                                                children: List.generate(
                                                  listProvider.length,
                                                  (index) {
                                                    ItemList list = listProvider[index];
                                                    return !list.isFinished!
                                                        ? Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () => GoRouter.of(context).push('/advListDetails/${list.itemId}'),
                                                                child: CustomListTile(
                                                                  constraints: constraints,
                                                                  list: list.name!,
                                                                  details: list.details!,
                                                                  isFinished: list.isFinished!,
                                                                  text: 'Alterado em',
                                                                  alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                                  delete: () => ref.read(userProvider.notifier).removeList(
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
                                      : Container(
                                          constraints: const BoxConstraints(minHeight: 100),
                                          width: constraints.maxWidth * .95,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 20.0,
                                              ),
                                              itemCount: listProvider.where((element) => element.isFinished! != true).toList().length,
                                              itemBuilder: (context, index) {
                                                ItemList list = listProvider.where((element) => element.isFinished! != true).toList()[index];

                                                return InkWell(
                                                  onTap: () => GoRouter.of(context).push('/advListDetails/${list.itemId}'),
                                                  child: CustomGridTile(
                                                    constraints: constraints,
                                                    list: list.name!,
                                                    details: list.details!,
                                                    isFinished: list.isFinished!,
                                                    text: 'Alterado em',
                                                    alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                    delete: () => ref.read(userProvider.notifier).removeList(
                                                          list.itemId,
                                                          context,
                                                        ),
                                                    edit: () => showModal(palette, list),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: SizedBox(
                                        height: 150,
                                        width: constraints.maxWidth,
                                        child: SvgPicture.asset(
                                          palette.homePageImage!,
                                          fit: BoxFit.contain,
                                          alignment: Alignment.center,
                                          colorFilter: ColorFilter.mode(palette.titleColor, BlendMode.modulate),
                                        ),
                                      ),
                                    ),
                              listProvider.any((element) => element.isFinished! && UtilsMethods.isYesterdayOrToday(element.finishedIn))
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ),
                                    )
                                  : const Center(),
                              const SizedBox(height: 20),
                              listProvider.isNotEmpty && listProvider.any((element) => element.isFinished! && UtilsMethods.isYesterdayOrToday(element.finishedIn))
                                  ? orientation == "list"
                                      ? Wrap(
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                children: List.generate(
                                                  listProvider.length,
                                                  (index) {
                                                    ItemList list = listProvider[index];
                                                    return list.isFinished! && UtilsMethods.isYesterdayOrToday(list.finishedIn)
                                                        ? Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () => GoRouter.of(context).push('/advListDetails/${list.itemId}'),
                                                                child: CustomListTile(
                                                                  constraints: constraints,
                                                                  list: list.name!,
                                                                  details: list.details!,
                                                                  isFinished: list.isFinished!,
                                                                  text: "Alterado em",
                                                                  alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                                  delete: () => ref.read(userProvider.notifier).removeList(
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
                                      : SizedBox(
                                          height: 180.0 * (listProvider.where((element) => element.isFinished!).toList().length),
                                          width: constraints.maxWidth * .95,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 20.0,
                                              ),
                                              itemCount: listProvider.where((element) => element.isFinished!).toList().length,
                                              itemBuilder: (context, index) {
                                                ItemList list = listProvider.where((element) => element.isFinished!).toList()[index];

                                                return list.isFinished! && UtilsMethods.isYesterdayOrToday(list.finishedIn)
                                                    ? InkWell(
                                                        onTap: () => GoRouter.of(context).push('/advListDetails/${list.itemId}'),
                                                        child: CustomGridTile(
                                                          constraints: constraints,
                                                          list: list.name!,
                                                          details: list.details!,
                                                          isFinished: list.isFinished!,
                                                          text: 'Alterado em',
                                                          alteredIn: DateFormat('dd/MM/yyyy').format(list.alteredIn),
                                                          delete: () => ref.read(userProvider.notifier).removeList(
                                                                list.itemId,
                                                                context,
                                                              ),
                                                          edit: () => showModal(palette, list),
                                                        ),
                                                      )
                                                    : const Center();
                                              },
                                            ),
                                          ),
                                        )
                                  : const Center(),
                              const SizedBox(height: 150),
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
