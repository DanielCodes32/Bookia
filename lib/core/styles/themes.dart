import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.DmSerif,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.backgroundColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.backgroundColor,
    ),

    cardColor: AppColors.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xffF7F8F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightgrey1),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      onSurface: AppColors.blackColor,
      seedColor: AppColors.primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    dividerColor: AppColors.lightgrey1,
  );
  static ThemeData get darktheme => ThemeData(
     dividerColor: AppColors.lightgrey1,
    cardColor: AppColors.blackColor,
    fontFamily: AppFonts.DmSerif,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyles.title.copyWith(
        color: AppColors.backgroundColor,
        fontFamily: AppFonts.DmSerif,
      ),
      elevation: 0,
      foregroundColor: AppColors.backgroundColor,
    ),
    colorScheme: ColorScheme.fromSeed(
      onSurface: AppColors.backgroundColor,
      seedColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xffF7F8F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightgrey1),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.blackColor,
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: AppColors.backgroundColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.blackColor,
      dialBackgroundColor: AppColors.blackColor,
      hourMinuteColor: AppColors.primaryColor,
    ),
  );
}
