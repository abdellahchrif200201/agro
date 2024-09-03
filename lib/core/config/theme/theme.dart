import 'package:devti_agro/core/config/constants/constants.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/assets.dart';

class AppTheme {
  static ThemeData getTheme({required bool isDark}) {
    return ThemeData(
      useMaterial3: false,
      fontFamily: kFontFam,
      primaryColor: isDark ? Colors.white : primaryColor,
      dividerColor: (isDark ? Colors.white : primaryColor).withOpacity(0.5),
      tabBarTheme: TabBarTheme(
        labelColor: isDark ? secondaryColor : primaryColor,
        unselectedLabelColor: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF838383),
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
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: isDark ? Colors.white : const Color(0xFF000000), width: 2),
        ),
      ),
      canvasColor: isDark ? Colors.black87 : backgroundColor,
      scaffoldBackgroundColor: isDark ? Colors.black87 : backgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: isDark ? Colors.black : Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white70 : Colors.black45,
          fontSize: 18.sp,
          fontFamily: kFontFam,
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: isDark ? secondaryColor : primaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        titleSmall: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
        labelMedium: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
        ),
        labelLarge: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        bodySmall: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Poppins",
          color: isDark ? secondaryColor : primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: isDark ? secondaryColor : primaryColor,
        primary: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF000000),
        secondary: const Color(0xFF00B14F),
        surface: isDark ? const Color(0xFF212121) : const Color(0xFFF5F5F5),
        onSurfaceVariant: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF333333),
        onSurface: isDark ? const Color(0xFF757575) : const Color(0xFF757575),
        onPrimary: isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
        onSecondary: isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
        error: const Color(0xFFE53935),
        onError: const Color(0xFFFFFFFF),
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (context) {
          return SvgPicture.asset(
            Assets.kSvgBurgerMenu,
            width: 23.w,
            color: isDark ? Colors.white : Colors.black,
          );
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF757575),
          fontSize: 14.sp,
          fontFamily: kFontFam,
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: isDark ? secondaryColor : primaryColor, width: 0.5.w),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: isDark ? secondaryColor : primaryColor, width: 1.w)),
          backgroundColor: WidgetStateProperty.all<Color>(isDark ? secondaryColor : primaryColor),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: isDark ? secondaryColor : primaryColor, width: 1.w)),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          foregroundColor: WidgetStateProperty.all<Color>(isDark ? secondaryColor : primaryColor),
        ),
      ),
    );
  }
}
