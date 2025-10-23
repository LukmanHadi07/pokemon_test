// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:pokemon_test/core/theme/font/body_font_style.dart';
import 'package:pokemon_test/core/theme/font/heading_font_style.dart';

class FontLocalTheme {
  final TextStyle bodySmallRegularFont;
  final TextStyle bodySmallSemiBoldFont;
  final TextStyle bodyMediumRegularFont;
  final TextStyle bodyMediumSemiBoldFont;
  final TextStyle bodyLargeRegularFont;
  final TextStyle bodyLargeSemiBoldFont;
  final TextStyle bodyExtraLargeRegularFont;
  final TextStyle bodyExtraLargeSemiBoldFont;

  final TextStyle headingExtraSmallSemiBoldFont;
  final TextStyle headingExtraSmallBoldFont;
  final TextStyle headingSmallSemiBoldFont;
  final TextStyle headingSmallBoldFont;
  final TextStyle headingMediumSemiBoldFont;
  final TextStyle headingMediumBoldFont;

  final TextStyle headingLargeBoldFont;
  final TextStyle headingExtraLargeBoldFont;
  final TextStyle headingDoubleExtraLargeBoldFont;
  final TextStyle headingTripleExtraLargeBoldFont;
  final TextStyle headingHeroBoldFont;
  final TextStyle headingHeaderBoldFont;

  FontLocalTheme({
    required this.bodySmallRegularFont,
    required this.bodySmallSemiBoldFont,
    required this.bodyMediumRegularFont,
    required this.bodyMediumSemiBoldFont,
    required this.bodyLargeRegularFont,
    required this.bodyLargeSemiBoldFont,
    required this.bodyExtraLargeRegularFont,
    required this.bodyExtraLargeSemiBoldFont,
    required this.headingExtraSmallSemiBoldFont,
    required this.headingExtraSmallBoldFont,
    required this.headingSmallSemiBoldFont,
    required this.headingSmallBoldFont,
    required this.headingMediumSemiBoldFont,
    required this.headingMediumBoldFont,
    required this.headingLargeBoldFont,
    required this.headingExtraLargeBoldFont,
    required this.headingDoubleExtraLargeBoldFont,
    required this.headingTripleExtraLargeBoldFont,
    required this.headingHeroBoldFont,
    required this.headingHeaderBoldFont,
  });

  static light() {
    return FontLocalTheme(
      bodySmallRegularFont: BodyFontStyle.bodySmallRegular,
      bodySmallSemiBoldFont: BodyFontStyle.bodySmallSemiBold,
      bodyMediumRegularFont: BodyFontStyle.bodyMediumRegular,
      bodyMediumSemiBoldFont: BodyFontStyle.bodyMediumSemiBold,
      bodyLargeRegularFont: BodyFontStyle.bodyLargeRegular,
      bodyLargeSemiBoldFont: BodyFontStyle.bodyLargeSemiBold,
      bodyExtraLargeRegularFont: BodyFontStyle.bodyExtraLargeRegular,
      bodyExtraLargeSemiBoldFont: BodyFontStyle.bodyExtraLargeSemiBold,
      headingExtraSmallSemiBoldFont: HeadingFontStyle.headingExtraSmallSemiBold,
      headingExtraSmallBoldFont: HeadingFontStyle.headingExtraSmallBold,
      headingSmallSemiBoldFont: HeadingFontStyle.headingSmallSemiBold,
      headingSmallBoldFont: HeadingFontStyle.headingSmallBold,
      headingMediumSemiBoldFont: HeadingFontStyle.headingMediumSemiBold,
      headingMediumBoldFont: HeadingFontStyle.headingMediumBold,
      headingLargeBoldFont: HeadingFontStyle.headingLargeBold,
      headingExtraLargeBoldFont: HeadingFontStyle.headingExtraLargeBold,
      headingDoubleExtraLargeBoldFont:
          HeadingFontStyle.headingDoubleExtraLargeBold,
      headingTripleExtraLargeBoldFont:
          HeadingFontStyle.headingTripleExtraLargeBold,
      headingHeroBoldFont: HeadingFontStyle.headingHeroBold,
      headingHeaderBoldFont: HeadingFontStyle.headingHeaderBold,
    );
  }

  static dark() {
    return FontLocalTheme(
      bodySmallRegularFont: BodyFontStyle.bodySmallRegular,
      bodySmallSemiBoldFont: BodyFontStyle.bodySmallSemiBold,
      bodyMediumRegularFont: BodyFontStyle.bodyMediumRegular,
      bodyMediumSemiBoldFont: BodyFontStyle.bodyMediumSemiBold,
      bodyLargeRegularFont: BodyFontStyle.bodyLargeRegular,
      bodyLargeSemiBoldFont: BodyFontStyle.bodyLargeSemiBold,
      bodyExtraLargeRegularFont: BodyFontStyle.bodyExtraLargeRegular,
      bodyExtraLargeSemiBoldFont: BodyFontStyle.bodyExtraLargeSemiBold,
      headingExtraSmallSemiBoldFont: HeadingFontStyle.headingExtraSmallSemiBold,
      headingExtraSmallBoldFont: HeadingFontStyle.headingExtraSmallBold,
      headingSmallSemiBoldFont: HeadingFontStyle.headingSmallSemiBold,
      headingSmallBoldFont: HeadingFontStyle.headingSmallBold,
      headingMediumSemiBoldFont: HeadingFontStyle.headingMediumSemiBold,
      headingMediumBoldFont: HeadingFontStyle.headingMediumBold,
      headingLargeBoldFont: HeadingFontStyle.headingLargeBold,
      headingExtraLargeBoldFont: HeadingFontStyle.headingExtraLargeBold,
      headingDoubleExtraLargeBoldFont:
          HeadingFontStyle.headingDoubleExtraLargeBold,
      headingTripleExtraLargeBoldFont:
          HeadingFontStyle.headingTripleExtraLargeBold,
      headingHeroBoldFont: HeadingFontStyle.headingHeroBold,
      headingHeaderBoldFont: HeadingFontStyle.headingHeaderBold,
    );
  }
}
