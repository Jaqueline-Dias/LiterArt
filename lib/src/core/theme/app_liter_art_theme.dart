import 'package:app_liter_art/src/core/utils/constants/const_colors.dart';
import 'package:flutter/material.dart';

final class LAAppTheme {
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: LAColors.softGrey),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: LAColors.violetDark),
    useMaterial3: true,
    fontFamily: 'Montserrat',
    appBarTheme: const AppBarTheme(
      backgroundColor: LAColors.primaryBackground,
      titleTextStyle: TextStyle(
        color: LAColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: LAColors.textPrimary,
      ),
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LAColors.secondary,
    ),
    scaffoldBackgroundColor: LAColors.primaryBackground,
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    )),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: LAColors.primaryBackground,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: LAColors.secondary,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: LAColors.violetDark,
        fontWeight: FontWeight.w600,
      ),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: LAColors.violetDark,
        ),
        foregroundColor: LAColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: LAColors.buttonPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
    ),
  );

  static final darkTheme = lightTheme;

  static const TextStyle authorMobileDateStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: LAColors.textPrimary,
  );

  static const TextStyle textInfoSearch = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: LAColors.buttonPrimary,
  );

  static const TextStyle textInfoAppBar = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: LAColors.buttonPrimary,
  );

  static const subTitleSmallStyle = TextStyle(
    color: LAColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const title = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const subtitleSmallDate = TextStyle(
    color: LAColors.textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const subtitleSplsh = TextStyle(
    color: LAColors.softGrey,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const titleDescription = TextStyle(
    color: LAColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const titleSubDescription = TextStyle(
    color: LAColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const titleDescriptionDropDown = TextStyle(
    color: LAColors.violetDark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const titleSplash = TextStyle(
    color: LAColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const subTitleSplash = TextStyle(
    color: LAColors.softGrey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
