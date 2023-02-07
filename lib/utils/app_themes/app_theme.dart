import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = _darkTheme;

  static ThemeData lightTheme = _lightTheme;
}

ThemeData _lightTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.light(primary: AppColors.primary),
).copyWith(
  scaffoldBackgroundColor: AppColors.white,
  dialogBackgroundColor: AppColors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.grey,
      elevation: 2,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.black),
  iconTheme: IconThemeData(color: AppColors.primary),
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(color: AppColors.gray),
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.gray),
    actionsIconTheme: IconThemeData(color: AppColors.gray),
    // foregroundColor: AppColors.textLight,
    //systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.primary,
    unselectedLabelColor: AppColors.black,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3.0, color: AppColors.primary),
        insets: const EdgeInsets.symmetric(horizontal: 150.0)),
  ),
  dialogTheme: const DialogTheme(
      //backgroundColor: AppColors.dialogLight,
      //shape: 12.shape,
      ),
);

ThemeData _darkTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(primary: AppColors.primary),
).copyWith(
  scaffoldBackgroundColor: AppColors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.secondary,
      elevation: 2,
      unselectedItemColor: Colors.white),
  iconTheme: const IconThemeData(color: AppColors.white),

  // dialogBackgroundColor: AppColors.dialogDark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(color: AppColors.white),
    backgroundColor: AppColors.black,
    iconTheme: const IconThemeData(color: AppColors.white),
    actionsIconTheme: const IconThemeData(color: AppColors.white),
    foregroundColor: AppColors.gray,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.white,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3.0, color: AppColors.white),
        insets: EdgeInsets.symmetric(horizontal: 150.0)),
  ),
);
