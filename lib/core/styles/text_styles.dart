import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle headline = TextStyle(
    fontSize: 30,
    fontFamily: AppFonts.DmSerif,
  );

  static TextStyle title = TextStyle(fontSize: 22);

  static TextStyle caption1 = TextStyle(
    fontSize: 15,
    color: AppColors.greycolor,
  );

  static TextStyle caption2 = TextStyle(
    color: AppColors.darkgreycolor,
    fontSize: 14,
  );
}
