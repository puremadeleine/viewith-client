import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

List<TextSpan> styledText(List<dynamic> parts) {
  return parts.map((e) {
    return TextSpan(
      text: e is String ? e : e.$1,
      style: AppDesign.typo.body1().copyWith(
        fontWeight: e is String ? null : (e.$2 is FontWeight ? e.$2 as FontWeight : null),
        color: e is String ? null : (e.$2 is Color ? e.$2 as Color : null),
      ),
    );
  }).toList();
}