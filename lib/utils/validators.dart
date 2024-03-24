class Validator {
  static String? changeInfoValidation(String? text, String textForm) {
    if (text == "") {
      return null;
    } else {
      switch (textForm) {
        case 'email':
          validateEmail(text);
          break;
        case 'cep':
          validateCEP(text!);
          break;
        case 'cpf':
          cpfValidate(text!);
          break;
        case 'cnpj':
          cpnjValidator(text!);
        default:
          validateNotEmpty(text);
          break;
      }
    }
    return null;
  }

  static String? cpnjValidator(String? cnpj) {
    if (cnpj == "") {
      return "Por favor, insira seu CPNJ";
    }
    // Remove caracteres especiais do CNPJ
    cnpj = cnpj?.replaceAll(RegExp(r'[^\d]'), '');

    // Verifica se o CNPJ possui 14 dígitos
    if (cnpj!.length != 14) {
      return 'CNPJ inválido';
    }

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      return 'CNPJ inválido';
    }

    // Calcula o primeiro dígito verificador
    var sum = 0;
    var weights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    for (var i = 0; i < 12; i++) {
      sum += int.parse(cnpj[i]) * weights[i];
    }
    var digit1 = sum % 11 < 2 ? 0 : 11 - (sum % 11);

    // Calcula o segundo dígito verificador
    sum = 0;
    weights.insert(0, 6);
    for (var i = 0; i < 13; i++) {
      sum += int.parse(cnpj[i]) * weights[i];
    }
    var digit2 = sum % 11 < 2 ? 0 : 11 - (sum % 11);

    // Verifica se os dígitos verificadores estão corretos
    if (digit1.toString() != cnpj[12] || digit2.toString() != cnpj[13]) {
      return 'CNPJ inválido';
    }

    // CNPJ válido
    return null;
  }

  static String? cpfValidate(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return "Por favor, insira seu CPF";
    }

    // Remove pontos e traços do CPF
    cpf = cpf.replaceAll(RegExp(r'[.-]'), '');

    // Verifica se o CPF possui 11 dígitos
    if (cpf.length != 11) {
      return 'CPF inválido';
    }

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return 'CPF inválido';
    }

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int digit1 = 11 - (sum % 11);
    if (digit1 > 9) {
      digit1 = 0;
    }

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int digit2 = 11 - (sum % 11);
    if (digit2 > 9) {
      digit2 = 0;
    }

    // Verifica se os dígitos verificadores estão corretos
    if (digit1.toString() != cpf[9] || digit2.toString() != cpf[10]) {
      return 'CPF inválido';
    }

    return null;
  }

  static String? validateNotEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return "Este campo não pode estar vazio";
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "O campo de e-mail não pode estar vazio";
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(email)) {
      return "Por favor, insira um endereço de e-mail válido";
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "A senha não pode estar vazia";
    }

    // Verifique se a senha contém pelo menos uma letra maiúscula.
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "A senha deve conter pelo menos \n uma letra maiúscula";
    }

    // Verifique se a senha contém pelo menos uma letra minúscula.
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "A senha deve conter pelo menos \n uma letra minúscula";
    }

    // Verifique se a senha contém pelo menos um caractere especial (@, -, _, $, #).
    if (!password.contains(RegExp(r'[@\-_$#]'))) {
      return "A senha deve conter pelo menos \n um caractere especial (@, -, _, \$, #)";
    }

    return null;
  }

  static String? cofirmPassword(String? confirmPassword, String password) {
    if (confirmPassword != "") {
      if (confirmPassword != password) {
        return "As senhas são diferentes";
      }
    } else {
      return "Por favor insira a senha";
    }
    return null;
  }

  static String? validateCEP(String cep) {
    // Remova qualquer caractere não numérico do CEP
    final cleanedCEP = cep.replaceAll(RegExp(r'[^\d]'), '');

    // Verifique se o CEP possui exatamente 8 dígitos
    if (cleanedCEP.length != 8) {
      return 'CEP deve conter exatamente 8 dígitos';
    }

    // Se passou por todas as verificações, o CEP é válido
    return null;
  }
}
