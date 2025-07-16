import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viewith/resource/constant.dart';
import 'package:xml/xml.dart';

class SvgUtil {
  static Future<Size> getSize(BuildContext context, String assetName) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), context);
    return pictureInfo.size;
  }

  static Matrix4 parseTransform(String transform) {
    final totalMatrix = Matrix4.identity();
    final regExp = RegExp(r'(\w+)\s*\(([^)]+)\)');
    final matches = regExp.allMatches(transform);

    for (final match in matches) {
      final command = match.group(1);
      final valuesStr = match.group(2)!.split(RegExp(r'[\s,]+')).where((s) => s.isNotEmpty);
      final values = valuesStr.map(double.parse).toList();
      final matrix = Matrix4.identity();

      switch (command) {
        case 'matrix':
          if (values.length == 6) {
            matrix.setValues(
              values[0], values[1], 0, 0, // col 1
              values[2], values[3], 0, 0, // col 2
              0, 0, 1, 0, // col 3
              values[4], values[5], 0, 1, // col 4
            );
          }
          break;
        case 'rotate':
          final angle = values[0] * (pi / 180.0);
          if (values.length == 3) {
            final cx = values[1];
            final cy = values[2];
            matrix.translate(cx, cy);
            matrix.rotateZ(angle);
            matrix.translate(-cx, -cy);
          } else {
            matrix.rotateZ(angle);
          }
          break;
        case 'translate':
          final tx = values[0];
          final ty = values.length > 1 ? values[1] : 0.0;
          matrix.translate(tx, ty);
          break;
      }
      totalMatrix.multiply(matrix);
    }
    return totalMatrix;
  }
}