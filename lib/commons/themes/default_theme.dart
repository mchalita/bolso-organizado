import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._();

  factory CustomTheme() {
    return CustomTheme._();
  }

  ThemeData get defaultTheme {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.blueOne,
      ),
    );

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColors.darkBlue,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.iceWhite,
        backgroundColor: AppColors.blue,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkBlue,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicator: BoxDecoration(
          border: Border(),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle:
            AppTextStyles.inputLabelText.copyWith(color: AppColors.grey),
        hintStyle: AppTextStyles.inputHintText.copyWith(color: AppColors.blue),
        focusedBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
        errorBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
        focusedErrorBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),
      ),
    );
  }
}
