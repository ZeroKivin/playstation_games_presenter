import 'package:flutter/material.dart';

import 'app_colors.dart';

const defaultFontFamily = 'Roboto';

class AppTypography {
  static const title = TextStyle(
    color: AppColors.typographyTitle,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    fontFamily: defaultFontFamily,
  );

  static const subtitle = TextStyle(
    color: AppColors.typographyWhite,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: defaultFontFamily,
  );

  static const body = TextStyle(
    color: AppColors.typographyPrimary,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontFamily: defaultFontFamily,
  );
}