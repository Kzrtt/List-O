import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/constants/prefsConstantes.dart';
import 'package:prj_list_app/utils/AppPreferences.dart';
import 'package:prj_list_app/widgets/editOptionTile.dart';

class UtilsMethods {
  static String getCorrectDate(DateTime date) {
    // Inicializa os dados de localização de data
    initializeDateFormatting('pt_BR', null); // Para português do Brasil

    // Cria um formatador de data
    DateFormat formatter = DateFormat('EEEE, d \'de\' MMMM', 'pt_BR');

    // Retorna a data formatada como string
    return formatter.format(date);
  }

  static String capatalize(String input) {
    List<String> words = input.split(' ');

    String capitalized = words.map((word) {
      if (word.isNotEmpty) {
        return word != "de" ? word[0].toUpperCase() + word.substring(1).toLowerCase() : 'de';
      }
      return word;
    }).join(' ');

    return capitalized;
  }

  static bool isYesterdayOrToday(DateTime dateToCheck) {
    DateTime now = DateTime.now();
    // Normalizando 'now' para meia-noite de hoje
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    // Verificando se a data para checagem é ontem ou hoje
    bool isToday = dateToCheck.year == today.year && dateToCheck.month == today.month && dateToCheck.day == today.day;
    bool isYesterday = dateToCheck.year == yesterday.year && dateToCheck.month == yesterday.month && dateToCheck.day == yesterday.day;

    return isYesterday || isToday;
  }

  static Color getMixedColor(Color color, {double opacity = 0.5, Color backgroundColor = Colors.white}) {
    int red = ((color.red * opacity) + (backgroundColor.red * (1 - opacity))).round();
    int green = ((color.green * opacity) + (backgroundColor.green * (1 - opacity))).round();
    int blue = ((color.blue * opacity) + (backgroundColor.blue * (1 - opacity))).round();

    return Color.fromRGBO(red, green, blue, 1); // Opacidade fixada em 1 para não reduzir a opacidade da cor resultante
  }

  static void showOptionsModal(BuildContext context, BoxConstraints constraints, AppPalette palette) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 600,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: palette.backgroundColor,
          ),
          child: Column(
            children: [
              Container(
                height: 150,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: palette.titleColor.withOpacity(.8),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    color: palette.tileColor,
                    size: 100,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
