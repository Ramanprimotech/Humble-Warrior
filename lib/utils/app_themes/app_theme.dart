
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

class AppTheme {


  static ThemeData darkTheme = _darkTheme;

  static ThemeData lightTheme = _lightTheme;




}

ThemeData _lightTheme = ThemeData.from(

  colorScheme: ColorScheme.light(primary: AppColors.primary),
  textTheme: TextTheme(
    displayLarge: _textTheme.displayLarge!.copyWith(
      color: AppColors.gray,
    ),
    displayMedium: _textTheme.displayMedium!.copyWith(
      color: AppColors.gray,
    ),
    displaySmall: _textTheme.displaySmall!.copyWith(
      color: AppColors.gray,
    ),
    headlineMedium: _textTheme.headlineMedium!.copyWith(
      color: AppColors.gray,
    ),
    headlineSmall: _textTheme.headlineSmall!.copyWith(
      color: AppColors.gray,
    ),
    titleLarge: _textTheme.titleLarge!.copyWith(
      color: AppColors.gray,
    ),
    titleMedium: _textTheme.titleMedium!.copyWith(
      color: AppColors.gray,
    ),
    titleSmall: _textTheme.titleSmall!.copyWith(
      color: AppColors.gray,
    ),
    bodyLarge: _textTheme.bodyLarge!.copyWith(
      color: AppColors.gray,
    ),
    bodyMedium: _textTheme.bodyMedium!.copyWith(
      color: AppColors.gray,
    ),
    labelLarge: _textTheme.labelLarge!.copyWith(
      color: AppColors.gray,
    ),
    bodySmall: _textTheme.bodySmall!.copyWith(
      color: AppColors.gray,
    ),
    labelSmall: _textTheme.labelSmall!.copyWith(
      color: AppColors.gray,
    ),
  ),
).copyWith(
  scaffoldBackgroundColor: AppColors.white,
  dialogBackgroundColor: AppColors.white,

  iconTheme:  IconThemeData(
      color: AppColors.primary

  ),
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
  tabBarTheme :  TabBarTheme(
    labelColor:AppColors.primary,
    unselectedLabelColor: AppColors.black,
    indicator:  UnderlineTabIndicator(

        borderSide: BorderSide(width: 3.0,color: AppColors.primary),
        insets: const EdgeInsets.symmetric(horizontal: 150.0)),



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
  scaffoldBackgroundColor: AppColors.black,
  iconTheme: const IconThemeData(
      color: AppColors.white

  ),

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
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   backgroundColor: AppColors.backgroundDark,
  //   elevation: 0,
  //   selectedLabelStyle: _textTheme.subtitle1!.copyWith(color: AppColors.primaryDark),
  //   unselectedLabelStyle: _textTheme.subtitle1!.copyWith(color: AppColors.textDark),
  //   type: BottomNavigationBarType.fixed,
  // ),
  // checkboxTheme: CheckboxThemeData(
  //   checkColor: MaterialStateProperty.resolveWith((_) => Colors.white),
  //   fillColor: MaterialStateProperty.resolveWith(
  //           () => .contains(MaterialState.selected) ? AppColors.primaryDark : AppColors.textDark),
  //   shape: 4.shape as OutlinedBorder?,
  //   visualDensity: VisualDensity.compact,
  // ),
  tabBarTheme:   const TabBarTheme(
    labelColor:AppColors.white,
    unselectedLabelColor: AppColors.white,
    indicator: UnderlineTabIndicator(

        borderSide: BorderSide(width: 3.0,color: AppColors.white),
        insets: EdgeInsets.symmetric(horizontal: 150.0)),



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