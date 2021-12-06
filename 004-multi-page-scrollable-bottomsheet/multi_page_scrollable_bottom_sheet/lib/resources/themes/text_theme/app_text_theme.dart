import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_page_scrollable_bottom_sheet/resources/colors/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme buildTextTheme() {
    final textTheme = TextTheme(
      headline1: GoogleFonts.varelaRound(
        fontSize: 98,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: AppColors.black,
      ),
      headline2: GoogleFonts.varelaRound(
        fontSize: 61,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: AppColors.black,
      ),
      headline3: GoogleFonts.varelaRound(
        fontSize: 49,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      headline4: GoogleFonts.varelaRound(
        fontSize: 35,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.black,
      ),
      headline5: GoogleFonts.varelaRound(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      headline6: GoogleFonts.varelaRound(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
        color: AppColors.black,
      ),
      subtitle1: GoogleFonts.varelaRound(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: AppColors.black60,
      ),
      subtitle2: GoogleFonts.varelaRound(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.black60,
      ),
      bodyText1: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.black60,
      ),
      bodyText2: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.black60,
      ),
      button: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: AppColors.black60,
      ),
      caption: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.black60,
      ),
      overline: GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: AppColors.black60,
      ),
    );
    return GoogleFonts.varelaRoundTextTheme(textTheme);
  }
}
