import 'package:ecoparking_management/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoParkingManagementThemes {
  static var fallbackTextTheme = TextTheme(
    displayLarge: GoogleFonts.beVietnamPro(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    displayMedium: GoogleFonts.beVietnamPro(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    displaySmall: GoogleFonts.beVietnamPro(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    headlineLarge: GoogleFonts.beVietnamPro(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    headlineMedium: GoogleFonts.beVietnamPro(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    headlineSmall: GoogleFonts.beVietnamPro(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    bodyLarge: GoogleFonts.beVietnamPro(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.0,
    ),
    bodyMedium: GoogleFonts.beVietnamPro(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    bodySmall: GoogleFonts.beVietnamPro(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    labelLarge: GoogleFonts.beVietnamPro(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
    ),
    labelMedium: GoogleFonts.beVietnamPro(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    labelSmall: GoogleFonts.beVietnamPro(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
    ),
  );

  static ThemeData buildTheme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.primaryColor,
          primary: AppConfig.primaryColor,
          onPrimary: AppConfig.onPrimaryColor,
          primaryContainer: AppConfig.primaryContainerColor,
          onPrimaryContainer: AppConfig.onPrimaryContainerColor,
          secondary: AppConfig.secondaryColor,
          onSecondary: AppConfig.onSecondaryColor,
          secondaryContainer: AppConfig.secondaryContainerColor,
          onSecondaryContainer: AppConfig.onSecondaryContainerColor,
          tertiary: AppConfig.tertiaryColor,
          onTertiary: AppConfig.onTertiaryColor,
          tertiaryContainer: AppConfig.tertiaryContainerColor,
          onTertiaryContainer: AppConfig.onTertiaryContainerColor,
          error: AppConfig.errorColor,
          surface: AppConfig.surfaceColor,
          onSurface: AppConfig.onSurfaceColor,
          onSurfaceVariant: AppConfig.onSurfaceVariantColor,
          surfaceContainerLowest: AppConfig.surfaceContainerLowestColor,
          surfaceContainerLow: AppConfig.surfaceContainerLow,
          surfaceContainer: AppConfig.surfaceContainer,
          surfaceContainerHigh: AppConfig.surfaceContainerHigh,
          surfaceContainerHighest: AppConfig.surfaceContainerHighest,
          surfaceTint: AppConfig.surfaceTintColor,
          inverseSurface: AppConfig.inverseSurfaceColor,
          onInverseSurface: AppConfig.onInverseSurfaceColor,
          inversePrimary: AppConfig.inversePrimaryColor,
          outline: AppConfig.outlineColor,
          outlineVariant: AppConfig.outlineVariantColor,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: AppConfig.onPrimaryColor,
          useIndicator: true,
          elevation: 1,
          indicatorColor: AppConfig.primaryColor,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: AppConfig.onPrimaryColor,
          indicatorColor: AppConfig.primaryColor,
          elevation: 1,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppConfig.onTertiaryColor,
        ),
        dataTableTheme: const DataTableThemeData(
          headingRowColor: WidgetStatePropertyAll<Color>(
            Colors.white,
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Colors.white,
          dialBackgroundColor: AppConfig.baseBackgroundColor,
          hourMinuteColor: AppConfig.outlineColor,
          dayPeriodColor: AppConfig.outlineColor,
        ),
        useMaterial3: true,
        fontFamily: GoogleFonts.beVietnamPro().fontFamily,
        textTheme: fallbackTextTheme,
      );
}
