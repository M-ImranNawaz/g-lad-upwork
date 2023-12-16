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
      fontSize: 55, fontWeight: FontWeight.bold, color: AppColors.headingColor);

  static void showLoading(BuildContext context,
      {Color color = AppColors.primaryColor, String? msg}) {
    showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.headingColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: color,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    msg ?? 'Please wait...',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static showSuccessSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 700),
        content: Text(error),
        backgroundColor: Colors.green,
      ),
    );
  }

  static showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(
          message,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(email);
  }
}
