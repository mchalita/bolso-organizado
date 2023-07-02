import 'dart:developer';

import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/utils/uppercase_text_formatter.dart';
import 'package:bolso_organizado/commons/utils/validator.dart';
import 'package:bolso_organizado/commons/widgets/custom_bottom_sheet.dart';
import 'package:bolso_organizado/commons/widgets/custom_circular_progress_indicator.dart';
import 'package:bolso_organizado/commons/widgets/custom_text_form_field.dart';
import 'package:bolso_organizado/commons/widgets/multi_text_button.dart';
import 'package:bolso_organizado/commons/widgets/password_form_field.dart';
import 'package:bolso_organizado/commons/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import 'sign_up_controller.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUpController = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signUpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signUpController.addListener(
      () {
        if (_signUpController.state is SignUpStateLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomCircularProgressIndicator(),
          );
        }
        if (_signUpController.state is SignUpStateSuccess) {
          Navigator.pop(context);

          Navigator.pushReplacementNamed(
            context,
            NamedRoute.HOME,
          );
        }

        if (_signUpController.state is SignUpStateError) {
          final error = _signUpController.state as SignUpStateError;
          Navigator.pop(context);
          showCustomModalBottomSheet(
            context: context,
            content: error.message,
            buttonText: "Tente novamente",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        key: Keys.signUpListView,
        children: [
          Image.asset(
            'assets/images/sign_up_image.png',
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  key: Keys.signUpNameField,
                  controller: _nameController,
                  labelText: "Nome",
                  hintText: "Nome",
                  inputFormatters: [
                    UpperCaseTextInputFormatter(),
                  ],
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  key: Keys.signUpEmailField,
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "email@email.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  key: Keys.signUpPasswordField,
                  controller: _passwordController,
                  labelText: "Senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                  helperText:
                      "Deve ter pelo menos 8 caracteres, 1 letra maiúscula e 1 número.",
                ),
                PasswordFormField(
                  key: Keys.signUpConfirmPasswordField,
                  labelText: "Confirmar senha",
                  hintText: "*********",
                  validator: (value) => Validator.validateConfirmPassword(
                    _passwordController.text,
                    value,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              key: Keys.signUpButton,
              text: 'Cadastrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _signUpController.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          MultiTextButton(
            key: Keys.signUpAlreadyHaveAccountButton,
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.SIGN_IN,
            ),
            children: [
              Text(
                'Já tem conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entrar',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.blueOne,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
