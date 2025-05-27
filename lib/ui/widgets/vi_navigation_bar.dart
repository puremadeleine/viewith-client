import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/vi_navigation_item.dart';

class VINavigationBar extends StatelessWidget {
  const VINavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterButtonTap,
  });

  final List<VINavigationItem> items;
  final int currentIndex;
  final void Function(int) onTap;
  final void Function() onCenterButtonTap;

  List<List<VINavigationItem>> _splitItems() {
    final middleIndex = items.length ~/ 2;
    return [
      items.sublist(0, middleIndex),
      items.sublist(middleIndex),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final splitItems = _splitItems();
    final leftItems = splitItems[0];
    final rightItems = splitItems[1];

    int getActualIndex(bool isLeft, int localIndex) {
      if (isLeft) return localIndex;
      return localIndex + leftItems.length;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          color: AppDesign.colors.gray200,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppDesign.colors.white,
          ),
          child: Padding(
            padding: AppDesign.spacing.horizontal24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...leftItems.asMap().entries.map((entry) {
                  final localIndex = entry.key;
                  final actualIndex = getActualIndex(true, localIndex);
                  final item = entry.value;
                  return GestureDetector(
                    onTap: () => onTap(actualIndex),
                    child: VINavigationItem(
                      icon: item.icon,
                      title: item.title,
                      isSelected: currentIndex == actualIndex,
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () => onCenterButtonTap(),
                  child: Container(
                    width: 56,
                    height: 56,
                    margin: AppDesign.spacing.vertical16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppDesign.colors.gray900,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                ...rightItems.asMap().entries.map((entry) {
                  final localIndex = entry.key;
                  final actualIndex = getActualIndex(false, localIndex);
                  final item = entry.value;
                  return GestureDetector(
                    onTap: () => onTap(actualIndex),
                    child: VINavigationItem(
                      icon: item.icon,
                      title: item.title,
                      isSelected: currentIndex == actualIndex,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
