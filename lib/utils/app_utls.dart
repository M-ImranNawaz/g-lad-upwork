import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppUtils {
  AppUtils._();

  static width(context) => MediaQuery.sizeOf(context).width;
  static height(context) => MediaQuery.sizeOf(context).width;

  static TextStyle get headTextStyle => const TextStyle(
    fontFamily: 'Klasik',
    fontSize: 38,
    fontWeight: FontWeight.w800,
    color: AppColors.headingColor,
  );

  static TextStyle get googleHeadTextStyle => GoogleFonts.caveat(
    fontSize: 55,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor
  );
}