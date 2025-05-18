import 'package:flutter/material.dart';

class TypographyTokens {
  // Font sizes
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size24 = 24;
  static const double size32 = 32;

  // Line heights
  static const double heightTight = 1.3;
  static const double heightNormal = 1.4;
  static const double heightRelaxed = 1.5;

  // Font weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

class AppTypography {
  TextStyle h1({Color? color}) => TextStyle(
        fontSize: 24,
        fontWeight: TypographyTokens.extraBold,
        height: 1.4,
        letterSpacing: -0.5,
        color: color,
      );

  TextStyle h2({Color? color}) => TextStyle(
        fontSize: 17,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );

  TextStyle h3({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );

  TextStyle title1({Color? color}) => TextStyle(
        fontSize: 23,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );

  TextStyle title1ExtraBold({Color? color}) => TextStyle(
        fontSize: 23,
        fontWeight: TypographyTokens.extraBold,
        height: 1.4,
        color: color,
      );

  TextStyle title2bold({Color? color}) => TextStyle(
        fontSize: 19,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );

  TextStyle title2semiBold({Color? color}) => TextStyle(
        fontSize: 19,
        fontWeight: TypographyTokens.semiBold,
        height: 1.4,
        color: color,
      );

  TextStyle title3semiBold({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: TypographyTokens.semiBold,
        height: 1.4,
        color: color,
      );

  TextStyle title3medium({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: TypographyTokens.medium,
        height: 1.4,
        color: color,
      );

  TextStyle body1({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: TypographyTokens.regular,
        height: 1.5,
        color: color,
      );

  TextStyle body1Bold({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: TypographyTokens.bold,
        height: 1.5,
        color: color,
      );

  TextStyle body1SemiBold({Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: TypographyTokens.semiBold,
        height: 1.5,
        color: color,
      );

  TextStyle body2({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: TypographyTokens.regular,
        height: 1.4,
        color: color,
      );

  TextStyle body2Bold({Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );

  TextStyle body3({Color? color}) => TextStyle(
        fontSize: 13,
        fontWeight: TypographyTokens.regular,
        height: 1.4,
        color: color,
      );

  TextStyle body4({Color? color}) => TextStyle(
        fontSize: 12,
        fontWeight: TypographyTokens.regular,
        height: 1.4,
        color: color,
      );

  TextStyle body4Bold({Color? color}) => TextStyle(
        fontSize: 12,
        fontWeight: TypographyTokens.bold,
        height: 1.4,
        color: color,
      );
}
