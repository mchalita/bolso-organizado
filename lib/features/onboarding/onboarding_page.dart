import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/extensions/extensions.dart';
import 'package:bolso_organizado/commons/widgets/multi_text_button.dart';
import 'package:bolso_organizado/commons/widgets/primary_button.dart';
import 'package:bolso_organizado/features/onboarding/onboarding_controller.dart';
import 'package:bolso_organizado/features/onboarding/onboarding_state.dart';
import 'package:bolso_organizado/locator.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final _onboardingController = locator.get<OnboardingController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));

    _onboardingController.isUserLogged();

    _onboardingController.addListener(() {
      if (_onboardingController.state is AuthenticatedUser) {
        final state = _onboardingController.state as AuthenticatedUser;

        if (state.isReady) {
          Navigator.pushReplacementNamed(context, NamedRoute.HOME,);
        }
      }
    });
  }

  @override
  void dispose() {
    _onboardingController.dispose();
    super.dispose();
  }

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
