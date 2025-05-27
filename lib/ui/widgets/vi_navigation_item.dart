import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

class VINavigationItem extends StatelessWidget {
  final IconData icon;
  final String? title;
  final bool isSelected;

  const VINavigationItem({
    super.key,
    required this.icon,
    this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final label = title;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? AppDesign.colors.gray900 : AppDesign.colors.gray500,
        ),
        if (label != null)
          Text(
            label,
            style: isSelected ? AppDesign.typo.body4Bold() : AppDesign.typo.body4(),
          ),
      ],
    );
  }
}
