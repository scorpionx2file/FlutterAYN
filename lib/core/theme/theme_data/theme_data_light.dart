import 'package:flutter/material.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_fonts.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

ThemeData getLightTheme(){
  return ThemeData(
    scaffoldBackgroundColor: AppColors.lightSilver,
    brightness: Brightness.light,
    fontFamily: AppFonts.notoKufiArabic,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.turnbullBlue,
      brightness: Brightness.light
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.spanishGrey),
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.turnbullBlue,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.spanishGrey,
        disabledForegroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
        minimumSize: Size(double.infinity, 52),
        textStyle: AppTextStyles.button
      )
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.darkYellow,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.button
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.turnbullBlue,
        side: const BorderSide(color: AppColors.turnbullBlue,width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: AppTextStyles.button
      )
    ),
  );
}