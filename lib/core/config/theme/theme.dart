// Flutter imports:

import 'package:devti_agro/core/config/constants/constants.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:

import 'package:flutter_svg/flutter_svg.dart';

import '../constants/assets.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: false,
      fontFamily: kFontFam,
      primaryColor: primaryColor,
      dividerColor: primaryColor.withOpacity(0.5),
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: Color(0xFF838383),
        labelStyle: TextStyle(
          fontSize: 11.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Color(0xFF000000), width: 2),
        ),
      ),
      canvasColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color.fromARGB(255, 148, 143, 143),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black45,
          fontSize: 18.sp,
          fontFamily: kFontFam,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: primaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        titleSmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        labelMedium: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
        ),
        labelLarge: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        bodySmall: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Poppins",
          color: primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: Color(0xFF000000), // Black for primary elements like AppBar, icons, etc.
        secondary: Color(0xFF00B14F), // Green for success indicators
        surface: Color(0xFFF5F5F5), // Light grey for cards and surfaces
        onSurfaceVariant: Color(0xFF333333), // Dark grey for text on background
        onSurface: Color(0xFF757575), // Grey for text on surfaces
        onPrimary: Color(0xFFFFFFFF), // White for text on primary color
        onSecondary: Color(0xFFFFFFFF), // White for text on secondary color
        error: Color(0xFFE53935), // Red for error indicators
        onError: Color(0xFFFFFFFF), // White for text on error color
        brightness: Brightness.light, // Brightness setting
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (context) {
          return SvgPicture.asset(
            Assets.kSvgBurgerMenu,
            width: 23.w,
          );
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        hintStyle: TextStyle(
          color: const Color(0xFF757575),
          fontSize: 14.sp,
          fontFamily: kFontFam,
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: primaryColor, width: 0.5.w),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: primaryColor, width: 1.w)),
          backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: primaryColor, width: 1.w)),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
        ),
      ),
    );
  }
}
