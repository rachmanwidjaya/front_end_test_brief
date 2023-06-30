import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static AppColors colors = AppColors.instance;
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: colors.primaryColor,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: colors.titleActive,
            letterSpacing: 0.12,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0.12,
            color: colors.bodyText,
          ),
          bodySmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.12,
            color: colors.bodyText,
          ),
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(color: colors.titleActive),
          titleTextStyle: GoogleFonts.poppins(
            color: colors.titleActive,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.12,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colors.primaryColor,
          unselectedItemColor: colors.bodyText,
          selectedIconTheme: IconThemeData(
            color: colors.primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: colors.bodyText,
          ),
        ),
      );
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: colors.primaryColor,
        canvasColor: colors.darkModeBackground,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: colors.darkModeTitle,
            letterSpacing: 0.12,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0.12,
            color: colors.darkModeTitle,
          ),
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          iconTheme: IconThemeData(
            color: colors.darkModeTitle,
          ),
          titleTextStyle: GoogleFonts.poppins(
            color: colors.darkModeTitle,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.12,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colors.primaryColor,
          unselectedItemColor: colors.darkModeBody,
          selectedIconTheme: IconThemeData(
            color: colors.primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: colors.darkModeBody,
          ),
        ),
      );
}
