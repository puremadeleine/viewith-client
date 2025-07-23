import 'package:flutter/material.dart';
class AppSpacing {
  const AppSpacing();

  final double _baseUnit = 4.0;

  double get sp2 => _baseUnit * 0.5;
  double get sp4 => _baseUnit;
  double get sp8 => _baseUnit * 2;
  double get sp12 => _baseUnit * 3;
  double get sp16 => _baseUnit * 4;
  double get sp20 => _baseUnit * 5;
  double get sp24 => _baseUnit * 6;
  double get sp32 => _baseUnit * 8;
  double get sp48 => _baseUnit * 12;
  double get sp64 => _baseUnit * 16;

  double get inlineGap => sp8;
  double get elementGap => sp16;
  double get sectionGap => sp32;

  SizedBox get h2 => SizedBox(height: sp2);
  SizedBox get h4 => SizedBox(height: sp4);
  SizedBox get h8 => SizedBox(height: sp8);
  SizedBox get h12 => SizedBox(height: sp12);
  SizedBox get h16 => SizedBox(height: sp16);
  SizedBox get h20 => SizedBox(height: sp20);
  SizedBox get h24 => SizedBox(height: sp24);
  SizedBox get h32 => SizedBox(height: sp32);
  SizedBox get h48 => SizedBox(height: sp48);
  SizedBox get h64 => SizedBox(height: sp64);

  SizedBox get w2 => SizedBox(width: sp2);
  SizedBox get w4 => SizedBox(width: sp4);
  SizedBox get w8 => SizedBox(width: sp8);
  SizedBox get w12 => SizedBox(width: sp12);
  SizedBox get w16 => SizedBox(width: sp16);
  SizedBox get w24 => SizedBox(width: sp24);
  SizedBox get w32 => SizedBox(width: sp32);
  SizedBox get w48 => SizedBox(width: sp48);
  SizedBox get w64 => SizedBox(width: sp64);

  SizedBox get square2 => SizedBox.square(dimension: sp2);
  SizedBox get square4 => SizedBox.square(dimension: sp4);
  SizedBox get square8 => SizedBox.square(dimension: sp8);
  SizedBox get square12 => SizedBox.square(dimension: sp12);
  SizedBox get square16 => SizedBox.square(dimension: sp16);
  SizedBox get square24 => SizedBox.square(dimension: sp24);
  SizedBox get square32 => SizedBox.square(dimension: sp32);
  SizedBox get square48 => SizedBox.square(dimension: sp48);
  SizedBox get square64 => SizedBox.square(dimension: sp64);

  EdgeInsets get horizontal8 => EdgeInsets.symmetric(horizontal: sp8);
  EdgeInsets get horizontal16 => EdgeInsets.symmetric(horizontal: sp16);
  EdgeInsets get horizontal24 => EdgeInsets.symmetric(horizontal: sp24);

  EdgeInsets get vertical4 => EdgeInsets.symmetric(vertical: sp4);
  EdgeInsets get vertical8 => EdgeInsets.symmetric(vertical: sp8);
  EdgeInsets get vertical16 => EdgeInsets.symmetric(vertical: sp16);
  EdgeInsets get vertical24 => EdgeInsets.symmetric(vertical: sp24);

  EdgeInsets get all8 => EdgeInsets.all(sp8);
  EdgeInsets get all16 => EdgeInsets.all(sp16);
  EdgeInsets get all24 => EdgeInsets.all(sp24);

  EdgeInsets get buttonPadding => EdgeInsets.symmetric(
    horizontal: sp16,
    vertical: sp8,
  );
  EdgeInsets get chipPadding => EdgeInsets.symmetric(
    horizontal: sp8,
    vertical: sp4,
  );
  EdgeInsets get cardPadding => EdgeInsets.all(sp16);
  EdgeInsets get listItemPadding => EdgeInsets.symmetric(
    horizontal: sp16,
    vertical: sp8,
  );
  EdgeInsets get screenPadding => EdgeInsets.symmetric(
    horizontal: sp24,
    vertical: sp16,
  );
}