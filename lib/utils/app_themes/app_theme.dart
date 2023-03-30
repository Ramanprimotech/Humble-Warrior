import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humble_warrior/hw.dart';
import 'package:humble_warrior/utils/theme_extention/account_option_theme_extentions.dart';
import 'package:humble_warrior/utils/theme_extention/image_icon_theme_extention.dart';
import 'package:humble_warrior/utils/theme_extention/shadow_theme_extention.dart';
import 'package:humble_warrior/utils/theme_extention/shop_button_theme.dart';

import '../app_colors.dart';
import '../theme_extention/custom_notice_theme_extention.dart';

class AppTheme {
  static ThemeData darkTheme = _darkTheme;

  static ThemeData lightTheme = _lightTheme;
}

ThemeData _lightTheme = ThemeData.from(
  colorScheme: ColorScheme.light(primary: AppColors.primary),
  textTheme: lightTextTheme,
).copyWith(
    extensions: <ThemeExtension>[
      const ImageIconTheme(
          textColor: Colors.black, backGroundColor: Colors.black),
      ShopNowTheme(textColor: AppColors.white, backGroundColor: AppColors.pink),
      AccountOptionTheme(
          shadow: AppColors.shadowLight,
          textColor: AppColors.greyText,
          backGroundColor: AppColors.white),
      const ShadowTheme(
          shadowColor: AppColors.shadowLight, background: AppColors.white),
      DialogueThemeExtention(
          backGroundColor: AppColors.white,
          textColor: AppColors.black,
          buttonColor: AppColors.primary,
          shadow: AppColors.shadowDark),
    ],
    cupertinoOverrideTheme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(color: AppColors.black))),
    scaffoldBackgroundColor: AppColors.white,
    dialogBackgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.primary),
    useMaterial3: true,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColors.white),
    appBarTheme: lightAppBarTheme,
    tabBarTheme: lightTabBarTheme,
    bottomNavigationBarTheme: lightBottomNavigationBarThemeData);

ThemeData _darkTheme = ThemeData.from(
  colorScheme: ColorScheme.dark(primary: AppColors.primary),
  textTheme: darkTextTheme,
).copyWith(
  extensions: <ThemeExtension<dynamic>>[
    ImageIconTheme(
        textColor: Colors.white,
        backGroundColor: AppColors.white.withOpacity(0.9)),
    ShopNowTheme(textColor: AppColors.white, backGroundColor: AppColors.pink),
    AccountOptionTheme(
        shadow: AppColors.shadowDark,
        textColor: AppColors.white,
        backGroundColor: AppColors.gray),
    ShadowTheme(
        shadowColor: AppColors.shadowDark, background: Colors.grey.shade800),
    DialogueThemeExtention(
        backGroundColor: AppColors.backgroundDark,
        textColor: AppColors.white,
        buttonColor: AppColors.primary,
        shadow: AppColors.shadowLight),
  ],
  cupertinoOverrideTheme: const CupertinoThemeData(
      textTheme:
          CupertinoTextThemeData(textStyle: TextStyle(color: AppColors.white))),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  iconTheme: const IconThemeData(color: AppColors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.backgroundDark),
  appBarTheme: darkAppBarTheme,
  bottomNavigationBarTheme: darkBottomNavigationBarThemeData,
  errorColor: AppColors.white,
  tabBarTheme: darkTabBarTheme,
  useMaterial3: true,
);

final TextTheme _textTheme = TextTheme(
  displayLarge: GoogleFonts.jost(
    fontSize: 110,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.jost(
    fontSize: 69,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: GoogleFonts.jost(
    fontSize: 55,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: GoogleFonts.jost(
    fontSize: 39,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headlineSmall: GoogleFonts.jost(
    fontSize: 28,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: GoogleFonts.jost(
    fontSize: 23,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.jost(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.jost(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: GoogleFonts.jost(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: GoogleFonts.jost(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

///====================Text Theme===========================///
///---Light
TextTheme lightTextTheme = TextTheme(
  displayLarge: _textTheme.displayLarge!.copyWith(
    color: AppColors.black,
  ),
  displayMedium: _textTheme.displayMedium!.copyWith(
    color: AppColors.black,
  ),
  displaySmall: _textTheme.displaySmall!.copyWith(
    color: AppColors.black,
  ),
  headlineMedium: _textTheme.headlineMedium!.copyWith(
    color: AppColors.black,
  ),
  headlineSmall: _textTheme.headlineSmall!.copyWith(
    color: AppColors.black,
  ),
  titleLarge: _textTheme.titleLarge!.copyWith(
    color: AppColors.black,
  ),
  titleMedium: _textTheme.titleMedium!.copyWith(
    color: AppColors.black,
  ),
  titleSmall: _textTheme.titleSmall!.copyWith(
    color: AppColors.black,
  ),
  bodyLarge: _textTheme.bodyLarge!.copyWith(
    color: AppColors.black,
  ),
  bodyMedium: _textTheme.bodyMedium!.copyWith(
    color: AppColors.black,
  ),
  labelLarge: _textTheme.labelLarge!.copyWith(
    color: AppColors.black,
  ),
  bodySmall: _textTheme.bodySmall!.copyWith(
    color: AppColors.black,
  ),
  labelSmall: _textTheme.labelSmall!.copyWith(
    color: AppColors.black,
  ),
);

///---Dark
TextTheme darkTextTheme = TextTheme(
  displayLarge: _textTheme.displayLarge!.copyWith(
    color: AppColors.white,
  ),
  displayMedium: _textTheme.displayMedium!.copyWith(
    color: AppColors.white,
  ),
  displaySmall: _textTheme.displaySmall!.copyWith(
    color: AppColors.white,
  ),
  headlineMedium: _textTheme.headlineMedium!.copyWith(
    color: AppColors.white,
  ),
  headlineSmall: _textTheme.headlineSmall!.copyWith(
    color: AppColors.white,
  ),
  titleLarge: _textTheme.titleLarge!.copyWith(
    color: AppColors.white,
  ),
  titleMedium: _textTheme.titleMedium!.copyWith(
    color: AppColors.white,
  ),
  titleSmall: _textTheme.titleSmall!.copyWith(
    color: AppColors.white,
  ),
  bodyLarge: _textTheme.bodyLarge!.copyWith(
    color: AppColors.white,
  ),
  bodyMedium: _textTheme.bodyMedium!.copyWith(
    color: AppColors.white,
  ),
  labelLarge: _textTheme.labelLarge!.copyWith(
    color: AppColors.white,
  ),
  bodySmall: _textTheme.bodySmall!.copyWith(
    color: AppColors.white,
  ),
  labelSmall: _textTheme.labelSmall!.copyWith(
    color: AppColors.white,
  ),
);

///====================Bottom Navigation Theme===========================///

///---Light
BottomNavigationBarThemeData lightBottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  elevation: 10,
  showUnselectedLabels: true,
  selectedItemColor: AppColors.primary,
  selectedIconTheme: IconThemeData(color: AppColors.primary, size: 32),
  unselectedIconTheme: const IconThemeData(color: AppColors.black, size: 32),
  selectedLabelStyle: TextStyle(
      color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12),
  unselectedLabelStyle:
      const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
  type: BottomNavigationBarType.fixed,
);

///---Dark
BottomNavigationBarThemeData darkBottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  elevation: 10,
  backgroundColor: AppColors.backgroundDark,
  showUnselectedLabels: true,
  selectedItemColor: AppColors.primary,
  selectedIconTheme: IconThemeData(color: AppColors.primary, size: 32),
  unselectedIconTheme: const IconThemeData(color: AppColors.white, size: 32),
  selectedLabelStyle: TextStyle(
      color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12),
  unselectedLabelStyle:
      const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
  type: BottomNavigationBarType.fixed,
);

///====================App Bar Theme===========================///

///---Light
AppBarTheme lightAppBarTheme = AppBarTheme(
  toolbarHeight: 70,
  // systemOverlayStyle: const SystemUiOverlayStyle(
  //   statusBarColor: Colors.white,
  //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
  // ),
  brightness: Brightness.light,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: TextStyle(color: AppColors.gray),
  surfaceTintColor: Colors.transparent,
  backgroundColor: AppColors.white,
  iconTheme: IconThemeData(color: AppColors.gray),
  actionsIconTheme: IconThemeData(color: AppColors.gray),
);

///---Dark
AppBarTheme darkAppBarTheme = AppBarTheme(
  // systemOverlayStyle: const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black,
  //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
  // ),
  brightness: Brightness.dark,
  toolbarHeight: 70,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: const TextStyle(color: AppColors.white),
  backgroundColor: AppColors.backgroundDark,
  surfaceTintColor: Colors.transparent,
  iconTheme: const IconThemeData(color: AppColors.white),
  actionsIconTheme: const IconThemeData(color: AppColors.white),
  foregroundColor: AppColors.gray,
);

///====================Tab Bar Theme===========================///

///---Light
TabBarTheme lightTabBarTheme = TabBarTheme(
  labelColor: AppColors.primary,
  unselectedLabelColor: AppColors.black,
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(width: 3.0, color: AppColors.primary),
  ),
);

///---Dark
TabBarTheme darkTabBarTheme = TabBarTheme(
  labelColor: AppColors.primary,
  unselectedLabelColor: AppColors.white,
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(width: 3.0, color: AppColors.primary),
  ),
);
