import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/gen/assets.gen.dart';

enum FilterType { sort, seat }

class FilterChipData {
  final String label;
  final FilterType type;

  FilterChipData({required this.label, required this.type});
}

class ChipList extends StatelessWidget {
  final List<FilterChipData> chips;
  final Function(FilterChipData) onRemove;

  const ChipList({
    super.key,
    required this.chips,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: chip.label,
              onRemove: () => onRemove(chip),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const FilterChip({
    super.key,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: AppDesign.typo.body1Bold(color: AppDesign.colors.white),
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      deleteIcon: Assets.images.closeFillWhite.svg(width: 20, height: 20),
      onDeleted: onRemove,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}
