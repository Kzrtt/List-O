import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prj_list_app/constants/appPalette.dart';
import 'package:prj_list_app/controllers/userProvider.dart';
import 'package:prj_list_app/models/User.dart';
import 'package:prj_list_app/utils/validators.dart';
import 'package:prj_list_app/widgets/buttonWithIcon.dart';
import 'package:prj_list_app/widgets/simpleHeader.dart';
import 'package:prj_list_app/widgets/textForms.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        const palette = AppPalette.darkColorPalette;
        User userToSignUp = User(
          name: "",
          email: "",
          photo: "",
          password: "",
          isAdvanced: false,
          itemList: [],
        );

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
                      children: [
                        SimpleHeader(
                          constraints: constraints,
                          secondText: "",
                          headerTitle: "Cadastro",
                          hasSpacing: false,
                          hasBackArrow: true,
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: signUpFormKey,
                          child: Column(
                            children: [
                              CustomTextFormFieldLogin(
                                constraints: constraints,
                                hintText: "seu nome",
                                label: "Nome",
                                validator: (text) => Validator.validateNotEmpty(text),
                                onSaved: (text) {
                                  setState(() {
                                    userToSignUp.name = text!;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormFieldLogin(
                                constraints: constraints,
                                hintText: "seu_email@gmail.com",
                                label: "Email",
                                validator: (text) => Validator.validateEmail(text),
                                onSaved: (text) {
                                  setState(() {
                                    userToSignUp.email = text!;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormFieldLogin(
                                constraints: constraints,
                                hintText: "senha",
                                label: "Senha",
                                validator: (text) => Validator.validatePassword(text),
                                onSaved: (text) {
                                  setState(() {
                                    userToSignUp.password = text!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWithIcon(
                              buttonText: "Voltar",
                              height: 40,
                              width: 150,
                              borderRadius: 10,
                              onTap: () => GoRouter.of(context).pop(),
                              iconSize: 20,
                              buttonColor: AppPalette.redColorPalette.tileColor,
                              iconColor: AppPalette.redColorPalette.titleColor,
                              textColor: AppPalette.redColorPalette.titleColor,
                              icon: Icons.arrow_back,
                            ),
                            ButtonWithIcon(
                              buttonText: "Cadastrar",
                              height: 40,
                              width: 150,
                              borderRadius: 10,
                              onTap: () async {
                                if (signUpFormKey.currentState!.validate()) {
                                  signUpFormKey.currentState!.save();
                                  int response = await ref.read(userProvider.notifier).signUp(
                                        userToSignUp,
                                        context,
                                      );
                                  if (response == 1) {
                                    GoRouter.of(context).pushReplacement('/homeScreen');
                                  }
                                }
                              },
                              iconSize: 20,
                              icon: Icons.person_add,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
