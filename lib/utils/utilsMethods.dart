import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
}
