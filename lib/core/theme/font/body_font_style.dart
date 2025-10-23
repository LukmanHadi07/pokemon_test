import 'package:flutter/material.dart';

class BodyFontStyle {
  static const _fontFamily = 'PlusJakartaSans';

  static final bodySmallRegular = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 16 / 12,
  );

  static final bodySmallSemiBold = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 16 / 12,
  );

  static final bodyMediumRegular = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: 14 * (-0.6 / 100),
    height: 20 / 14,
  );

  static final bodyMediumSemiBold = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: 14 * (-0.6 / 100),
    height: 20 / 14,
  );

  static final bodyLargeRegular = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: 16 * (-1.1 / 100),
    height: 24 / 16,
  );

  static final bodyLargeSemiBold = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: 16 * (-1.1 / 100),
    height: 24 / 16,
  );

  static final bodyExtraLargeRegular = TextStyle(
    fontSize: 20,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: 20 * (-1.7 / 100),
    height: 28 / 20,
  );

  static final bodyExtraLargeSemiBold = TextStyle(
    fontSize: 20,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: 20 * (-1.7 / 100),
    height: 28 / 20,
  );
}
