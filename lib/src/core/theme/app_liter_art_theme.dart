import 'package:flutter/material.dart';

final class AppLiterArtTheme {
  static const violetLigth = Color(0xFFB691E5);
  static const violetBackground = Color(0xFFD8BAFF);
  static const violetDark = Color(0xFF7A15B2);
  static const violetButton = Color(0xFFB691E5);
  static const violetFillDark = Color(0xFFF1E8FF);
  static const violetFillligth = Color(0xFFDFD5F4);
  static const violetLigth2 = Color(0xFFF6EDFF);
  static const violetDropMenu = Color(0xFFF1EBFF);
  static const grey = Color(0xFF334252);
  static const greyLigth = Color(0xFF707070);
  static const red = Color(0xFFEB1212);
  static const greyScaffoldBackgroundColor = Color(0xFFFEFAFF);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: greyLigth),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: violetDark),
    useMaterial3: true,
    fontFamily: 'Montserrat',
    appBarTheme: const AppBarTheme(
      backgroundColor: greyScaffoldBackgroundColor,
      titleTextStyle: TextStyle(
        color: violetDark,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: violetDark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: violetLigth,
    ),
    scaffoldBackgroundColor: greyScaffoldBackgroundColor,
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    )),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: greyScaffoldBackgroundColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: violetLigth,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: violetDark,
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
          color: violetDark,
        ),
        foregroundColor: violetLigth,
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
        backgroundColor: violetButton,
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

  static const subTitleSmallStyle = TextStyle(
    color: grey,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const titleAlertDialog = TextStyle(
    color: grey,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const title = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const subtitleSmallDate = TextStyle(
    color: grey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const subtitleSplsh = TextStyle(
    color: greyLigth,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const titleDescription = TextStyle(
    color: grey,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const titleSubDescription = TextStyle(
    color: grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const titleDescriptionDropDown = TextStyle(
    color: violetDark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const titleSplash = TextStyle(
    color: grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const subTitleSplash = TextStyle(
    color: greyLigth,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
