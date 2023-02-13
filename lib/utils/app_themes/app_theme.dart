import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humble_warrior/utils/theme_extention/account_option_theme_extentions.dart';
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
  textTheme: TextTheme(
    headline1: _textTheme.headline1!.copyWith(
      color: AppColors.gray,
    ),
    headline2: _textTheme.headline2!.copyWith(
      color: AppColors.gray,
    ),
    headline3: _textTheme.headline3!.copyWith(
      color: AppColors.gray,
    ),
    headline4: _textTheme.headline4!.copyWith(
      color: AppColors.gray,
    ),
    headline5: _textTheme.headline5!.copyWith(
      color: AppColors.gray,
    ),
    headline6: _textTheme.headline6!.copyWith(
      color: AppColors.gray,
    ),
    subtitle1: _textTheme.subtitle1!.copyWith(
      color: AppColors.gray,
    ),
    subtitle2: _textTheme.subtitle2!.copyWith(
      color: AppColors.gray,
    ),
    bodyText1: _textTheme.bodyText1!.copyWith(
      color: AppColors.gray,
    ),
    bodyText2: _textTheme.bodyText2!.copyWith(
      color: AppColors.gray,
    ),
    button: _textTheme.button!.copyWith(
      color: AppColors.gray,
    ),
    caption: _textTheme.caption!.copyWith(
      color: AppColors.gray,
    ),
    overline: _textTheme.overline!.copyWith(
      color: AppColors.gray,
    ),
  ),
).copyWith(
  extensions: <ThemeExtension>[
    ShopNowTheme(textColor: AppColors.white, backGroundColor: AppColors.pink),
    AccountOptionTheme(
        shadow: AppColors.shadowLight,
        textColor: AppColors.greyText,
        backGroundColor: AppColors.white),
    const ShadowTheme(shadowColor: AppColors.shadowLight),
    DialogueThemeExtention(
        backGroundColor: AppColors.white,
        textColor: AppColors.gray,
        buttonColor: AppColors.primary,
        shadow: AppColors.shadowLight),
  ],
  cupertinoOverrideTheme: CupertinoThemeData(
      textTheme:
          CupertinoTextThemeData(textStyle: TextStyle(color: AppColors.black))),
  scaffoldBackgroundColor: AppColors.white,
  dialogBackgroundColor: AppColors.white,

  iconTheme: IconThemeData(color: AppColors.primary),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: AppColors.white),
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
        insets: EdgeInsets.symmetric(horizontal: 150.0)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // backgroundColor: ,
    elevation: 10,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.primary,
    selectedIconTheme: IconThemeData(color: AppColors.primary, size: 24),
    unselectedIconTheme: IconThemeData(color: AppColors.black, size: 24),
    selectedLabelStyle: TextStyle(color: AppColors.primary, fontSize: 12),
    unselectedLabelStyle: TextStyle(color: AppColors.black),
    type: BottomNavigationBarType.fixed,
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   alignLabelWithHint: true,
  //   filled: true,
  //   fillColor: AppColors.backgroundLight,
  //   labelStyle: TextStyle(
  //     color: AppColors.textDark,
  //     fontFamily: appFontFamily,
  //   ),
  //   hintStyle: TextStyle(
  //     color: AppColors.textDark,
  //     fontFamily: appFontFamily,
  //   ),
  //   isDense: true,
  // ),
  // switchTheme: SwitchThemeData(
  //   thumbColor: MaterialStateProperty.resolveWith(
  //         () => .contains(MaterialState.selected) ? Colors.white : AppColors.thumbColor,
  //   ),
  //   trackColor: MaterialStateProperty.resolveWith(
  //         () => .contains(MaterialState.selected) ? AppColors.primaryLight : Colors.grey,
  //   ),
  // ),
);

ThemeData _darkTheme = ThemeData.from(
  colorScheme: ColorScheme.dark(primary: AppColors.primary),
  textTheme: TextTheme(
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
  ),
).copyWith(
  extensions: <ThemeExtension<dynamic>>[
    ShopNowTheme(textColor: AppColors.white, backGroundColor: AppColors.pink),
    AccountOptionTheme(
        shadow: AppColors.shadowDark,
        textColor: AppColors.white,
        backGroundColor: AppColors.gray),
    const ShadowTheme(shadowColor: AppColors.shadowDark),
    DialogueThemeExtention(
        backGroundColor: AppColors.backgroundDark,
        textColor: AppColors.white,
        buttonColor: AppColors.primary,
        shadow: AppColors.shadowDark),
  ],
  cupertinoOverrideTheme: CupertinoThemeData(
      textTheme:
          CupertinoTextThemeData(textStyle: TextStyle(color: AppColors.white))),
  scaffoldBackgroundColor: AppColors.black,
  iconTheme: const IconThemeData(color: AppColors.white),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: AppColors.backgroundDark),
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
  // dialogTheme: DialogTheme(
  //   backgroundColor: AppColors.dialogDark,
  //   shape: 12.shape,
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // backgroundColor: ,
    elevation: 10,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.primary,
    selectedIconTheme: IconThemeData(color: AppColors.primary, size: 24),
    unselectedIconTheme: IconThemeData(color: AppColors.gray, size: 24),
    selectedLabelStyle: TextStyle(color: AppColors.primary, fontSize: 12),
    unselectedLabelStyle: TextStyle(color: AppColors.gray),
    type: BottomNavigationBarType.fixed,
  ),
  // checkboxTheme: CheckboxThemeData(
  //   checkColor: MaterialStateProperty.resolveWith((_) => Colors.white),
  //   fillColor: MaterialStateProperty.resolveWith(
  //           () => .contains(MaterialState.selected) ? AppColors.primaryDark : AppColors.textDark),
  //   shape: 4.shape as OutlinedBorder?,
  //   visualDensity: VisualDensity.compact,
  // ),
  errorColor: AppColors.white,
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.primary,
    unselectedLabelColor: AppColors.white,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 3.0, color: AppColors.primary),
    ),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   alignLabelWithHint: true,
  //   filled: true,
  //   fillColor: AppColors.backgroundDark,
  //   labelStyle: TextStyle(
  //     color: AppColors.textDark,
  //     fontFamily: appFontFamily,
  //   ),
  //   hintStyle: TextStyle(
  //     color: AppColors.textDark,
  //     fontFamily: appFontFamily,
  //   ),
  //   isDense: true,
  // ),
  // switchTheme: SwitchThemeData(
  //   thumbColor: MaterialStateProperty.resolveWith(
  //         () => .contains(MaterialState.selected) ? Colors.white : AppColors.thumbColor,
  //   ),
  //   trackColor: MaterialStateProperty.resolveWith(
  //         () => .contains(MaterialState.selected) ? AppColors.primaryDark : Colors.grey,
  //   ),
  // ),
);

final TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.jost(
    fontSize: 110,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.jost(
    fontSize: 69,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.jost(
    fontSize: 55,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.jost(
    fontSize: 39,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.jost(
    fontSize: 28,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.jost(
    fontSize: 23,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.jost(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.jost(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.jost(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.jost(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.jost(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
