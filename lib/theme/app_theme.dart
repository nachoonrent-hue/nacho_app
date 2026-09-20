import 'package:flutter/material.dart';

/// Motion constants shared across the app for a consistent feel.
class AppMotion {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 560);

  static const Curve entrance = Curves.easeOutCubic;
  static const Curve spring = Curves.easeOutBack;
  static const Curve pop = Curves.elasticOut;
}

/// Global page-transition so every screen push feels smooth & cohesive.
class FadeSlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadeSlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.035),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

class AppColors {
  static const Color primaryPlum = Color(0xFF4B164C);
  static const Color saffron = Color(0xFFE58A24);
  static const Color saffronAccent = Color(0xFFFF9E2A);
  static const Color warmIvory = Color(0xFFFFF9F2);
  static const Color charcoal = Color(0xFF211F23);
  static const Color secondaryText = Color(0xFF6F6A70);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color emeraldSuccess = Color(0xFF16805B);
  static const Color warning = Color(0xFFC87916);
  static const Color errorRed = Color(0xFFC94A4A);
  static const Color borderLight = Color(0xFFEDE4DC);
  static const Color chipBackground = Color(0xFFF3EAE1);
}

class AppTypography {
  static const TextStyle display = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.bold,
    color: AppColors.charcoal,
    letterSpacing: -0.5,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.charcoal,
    letterSpacing: -0.3,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.charcoal,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.charcoal,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    color: AppColors.charcoal,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static const TextStyle small = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.warmIvory,
      primaryColor: AppColors.primaryPlum,
      splashFactory: InkSparkle.splashFactory,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryPlum,
        secondary: AppColors.saffron,
        surface: AppColors.cardSurface,
        error: AppColors.errorRed,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.charcoal,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.iOS: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.macOS: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.windows: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.linux: FadeSlidePageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeSlidePageTransitionsBuilder(),
        },
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.warmIvory,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.charcoal),
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.charcoal,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 1.5,
        shadowColor: AppColors.primaryPlum.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPlum,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: AppTypography.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryPlum,
          side: const BorderSide(color: AppColors.primaryPlum, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: AppTypography.button.copyWith(
            color: AppColors.primaryPlum,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: AppColors.primaryPlum,
            width: 1.5,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryPlum,
        unselectedItemColor: AppColors.secondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryPlum,
        unselectedLabelColor: AppColors.secondaryText,
        indicatorColor: AppColors.primaryPlum,
        dividerColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(AppColors.primaryPlum),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.saffron,
        linearTrackColor: Color(0x33FFFFFF),
        circularTrackColor: Color(0x33FFFFFF),
      ),
    );
  }
}
