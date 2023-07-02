import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/widgets/multi_text_button.dart';
import 'package:bolso_organizado/commons/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Column(
        children: [
          const SizedBox(height: 48.0),
          Expanded(
            child: Image.asset(
              'assets/images/onboarding_image.png',
            ),
          ),
          Text(
            'Bolso Organizado',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.blueOne,
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
              key: Keys.onboardingGetStartedButton,
              text: 'Cadastrar',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.SIGN_UP,
                );
              },
            ),
          ),
          MultiTextButton(
            key: Keys.onboardingAlreadyHaveAccountButton,
            onPressed: () => Navigator.pushNamed(context, NamedRoute.SIGN_IN),
            children: [
              Text(
                'Já possui uma conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entrar ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.blueOne,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
