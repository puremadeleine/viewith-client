import 'package:flutter/material.dart';
import '../../model/seat_section.dart';

class PathPainter extends CustomPainter {
  final List<Section> sections;
  final Map<String, Color> colors;
  final Map<String, Color> borderColors;
  final Color defaultColor;
  final Color defaultBorderColor;
  final double scale;

  PathPainter({
    required this.sections,
    required this.colors,
    required this.borderColors,
    required this.defaultColor,
    required this.defaultBorderColor,
    required this.scale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale, scale);

    for (final section in sections) {
      final fillPaint = Paint()
        ..color = _getSectionColor(section)
        ..style = PaintingStyle.fill;
      canvas.drawPath(section.path, fillPaint);

      final borderColor = borderColors[section.id];
      if (borderColor != null) {
        final borderPaint = Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0 / scale; // 스케일에 따라 두께 조절

        canvas.drawPath(section.path, borderPaint);
      }
    }
  }

  Color _getSectionColor(Section section) {
    return colors[section.id] ?? defaultColor;
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.colors != colors || oldDelegate.borderColors != borderColors;
  }
}
