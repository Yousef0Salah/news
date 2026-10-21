import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/theme/app_text_style.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.black,
    textTheme: TextTheme(
      titleLarge: AppText.s32wB.copyWith(color: AppColors.white),
      titleMedium: AppText.s24w5.copyWith(color: AppColors.black),
      titleSmall: AppText.s20w5.copyWith(color: AppColors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.white,
    

    textTheme: TextTheme(
      titleLarge: AppText.s32wB.copyWith(color: AppColors.black),
      titleMedium: AppText.s24w5.copyWith(color: AppColors.white),
      titleSmall: AppText.s20w5.copyWith(color: AppColors.white),
    ),
  );
}
