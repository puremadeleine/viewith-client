import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const double width = 104.0;
    const double height = 30.0;
    const double circleSize = 20.0;

    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value ? AppDesign.colors.gray900 : AppDesign.colors.gray300,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppDesign.colors.white,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  text,
                  style: AppDesign.typo.body4Bold(
                    color: AppDesign.colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 