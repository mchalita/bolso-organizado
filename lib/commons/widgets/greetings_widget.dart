import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double textScaleFactor =
        MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bolso Organizado',
          textScaleFactor: textScaleFactor,
          style: AppTextStyles.mediumText20.apply(color: AppColors.white),
        ),
      ],
    );
  }
}
