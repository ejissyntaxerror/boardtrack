import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0B5FFF); // vivid blue
  static const Color primaryVariant = Color(0xFF084ECC);
  static const Color secondary = Color(0xFFFFA726); // warm orange
  static const Color background = Color(0xFFF7F9FC); // light neutral
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black87;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;
}

class AppTextStyles {
  AppTextStyles._();

  // Using Inter for body/ui and Merriweather for headings
  static final TextStyle headline1 =
      GoogleFonts.merriweather(fontSize: 28, fontWeight: FontWeight.w700, height: 1.2, color: AppColors.onBackground);
  static final TextStyle headline2 =
      GoogleFonts.merriweather(fontSize: 22, fontWeight: FontWeight.w700, height: 1.2, color: AppColors.onBackground);
  static final TextStyle title =
      GoogleFonts.merriweather(fontSize: 18, fontWeight: FontWeight.w600, height: 1.2, color: AppColors.onBackground);
  static final TextStyle bodyLarge =
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.4, color: AppColors.onBackground);
  static final TextStyle bodySmall =
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.3, color: AppColors.onBackground);
  static final TextStyle caption =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, height: 1.2, color: Colors.black54);
  static final TextStyle button =
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onPrimary);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light();
    final colorScheme = ColorScheme(
      primary: AppColors.primary,
      primaryVariant: AppColors.primaryVariant,
      secondary: AppColors.secondary,
      secondaryVariant: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onBackground: AppColors.onBackground,
      onError: Colors.white,
      brightness: Brightness.light,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: AppTextStyles.title,
        iconTheme: const IconThemeData(color: AppColors.onSurface),
      ),
      textTheme: TextTheme(
        headline1: AppTextStyles.headline1,
        headline2: AppTextStyles.headline2,
        headline6: AppTextStyles.title,
        bodyText1: AppTextStyles.bodyLarge,
        bodyText2: AppTextStyles.bodySmall,
        caption: AppTextStyles.caption,
        button: AppTextStyles.button,
      ).apply(bodyColor: AppColors.onBackground, displayColor: AppColors.onBackground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: AppColors.primary, textStyle: AppTextStyles.bodyLarge),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.primary)),
        hintStyle: AppTextStyles.caption,
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      dividerColor: Colors.grey.shade200,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary),
      ),
    );
  }
}
