import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/res/theme/app_colors.dart';
import 'package:playstation_games_presenter/res/theme/app_typography.dart';

class AppTheme {
  AppTheme._(this.themeData);

  factory AppTheme.light() {
    return AppTheme._(
      ThemeData.from(
              colorScheme: const ColorScheme(
                primary: AppColors.primary,
                secondary: AppColors.accent,
                background: AppColors.background,
                surface: AppColors.background,
                error: AppColors.error,
                onPrimary: AppColors.background,
                onSecondary: AppColors.background,
                onBackground: AppColors.primary,
                onSurface: AppColors.primary,
                onError: AppColors.background,
                primaryVariant: AppColors.primary,
                secondaryVariant: AppColors.accent,
                brightness: Brightness.light,
              ),
              textTheme: const TextTheme(
                  headline3: AppTypography.title,
                  subtitle1: AppTypography.subtitle,
                  bodyText1: AppTypography.body))
          .copyWith(
              appBarTheme: const AppBarTheme(
        color: AppColors.primary,
      )),
    );
  }

  final ThemeData themeData;
}
