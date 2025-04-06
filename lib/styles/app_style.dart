import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'palette.dart';

class Styles {

  static ThemeData themeData({required bool isDark}) {
    return ThemeData(
      fontFamily: 'NotoSans',
      primaryColor: black(isDark),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: white(isDark),
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: black(isDark),
        secondary: iris9(isDark),
        surface: black(isDark),
        error: red9(isDark),
        onPrimary: white(isDark),
        onSecondary: white(isDark),
        onSurface: white(isDark),
        onError: black(isDark),
        brightness: isDark? Brightness.dark : Brightness.light,

        background: stateColor10(isDark),
        onBackground: white(isDark),
      ),

      splashColor: stateColor6(isDark),
      highlightColor: stateColor3(isDark),

      disabledColor: Colors.grey,
      iconTheme: IconThemeData(
          color: stateColor11(isDark)
      ),
      dividerTheme: DividerThemeData(
          color: stateColor7(isDark),
          thickness: 1.5.h
      ),

      /// TEXT THEME
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 13.33.sp,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        titleLarge: TextStyle(
            fontSize: 19.20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
        labelMedium: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            color: const Color(0xFFC3C3C3)
        ),
        labelSmall: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: const Color(0xFFC3C3C3)
        ),

      ),

      /// INPUT THEME
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
        isDense: true,

        hintStyle: TextStyle(
          color: stateColor10(isDark),
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: stateColor10(isDark)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: stateColor6(isDark), width: 1.sp),
            borderRadius: BorderRadius.circular(4.r)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.sp, color: Colors.transparent),
            borderRadius: BorderRadius.circular(4.r)
        ),
        errorBorder:OutlineInputBorder(
            borderSide: BorderSide(width: 1.sp, color: red9(isDark)),
            borderRadius: BorderRadius.circular(4.r)
        ),
        errorStyle: TextStyle(
          color: red9(isDark),
          fontSize: 13.33.sp,
          fontWeight: FontWeight.w500,
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.sp, color: Colors.transparent),
            borderRadius: BorderRadius.circular(4.r)
        ),
        focusedErrorBorder:OutlineInputBorder(
            borderSide: BorderSide(width: 1.sp, color: Colors.transparent),
            borderRadius: BorderRadius.circular(4.r)
        ),
        filled: true,
        fillColor: white(isDark),
      ),


      cardColor: white(isDark),
      canvasColor: stateColor1(isDark),
      brightness: Brightness.light,
      appBarTheme:  AppBarTheme(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        systemOverlayStyle: isDark == true? SystemUiOverlayStyle.light: SystemUiOverlayStyle.dark,
        color: Colors.transparent,
        foregroundColor: stateColor12(isDark),
        iconTheme: IconThemeData(color: stateColor1(isDark)),
        titleTextStyle: TextStyle(
          fontSize: 19.20.sp,
          fontWeight: FontWeight.w700,
          color: stateColor1(isDark),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF5C5C5C),
      shadowColor: Colors.grey,
    );

  }
}