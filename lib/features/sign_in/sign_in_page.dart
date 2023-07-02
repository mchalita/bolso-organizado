import 'dart:developer';

import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/utils/validator.dart';
import 'package:bolso_organizado/commons/widgets/custom_bottom_sheet.dart';
import 'package:bolso_organizado/commons/widgets/custom_circular_progress_indicator.dart';
import 'package:bolso_organizado/commons/widgets/custom_text_form_field.dart';
import 'package:bolso_organizado/commons/widgets/multi_text_button.dart';
import 'package:bolso_organizado/commons/widgets/password_form_field.dart';
import 'package:bolso_organizado/commons/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import 'sign_in_controller.dart';
import 'sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInController = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _signInController.addListener(
      () {
        if (_signInController.state is SignInStateLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomCircularProgressIndicator(),
          );
        }
        if (_signInController.state is SignInStateSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.HOME,
          );
        }

        if (_signInController.state is SignInStateError) {
          final error = _signInController.state as SignInStateError;
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
        key: Keys.signInListView,
        children: [
          Text(
            'Bem vindo!',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.blueOne,
            ),
          ),
          Image.asset(
            'assets/images/sign_in_image.png',
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  key: Keys.signInEmailField,
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "email@email.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  key: Keys.signInPasswordField,
                  controller: _passwordController,
                  labelText: "Senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                  helperText:
                      "Deve ter pelo menos 8 caracteres, 1 letra maiúscula e 1 número.",
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
              key: Keys.signInButton,
              text: 'Entrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _signInController.signIn(
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
            key: Keys.signInDontHaveAccountButton,
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.SIGN_UP,
            ),
            children: [
              Text(
                'Não tem uma conta?',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Cadastrar',
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
