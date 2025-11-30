import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

class FloorRowSelector extends StatefulWidget {
  final Map<String, List<String>> seats;

  final Function(String floor) onFloorSelected;

  final Function(String row) onRowSelected;

  final String? initialFloor;

  final String? initialRow;

  const FloorRowSelector({
    super.key,
    required this.seats,
    required this.onFloorSelected,
    required this.onRowSelected,
    this.initialFloor,
    this.initialRow,
  });

  @override
  State<FloorRowSelector> createState() => _FloorRowSelectorState();
}

class _FloorRowSelectorState extends State<FloorRowSelector> {
  String? selectedFloor;
  String? selectedRow;

  List<String> floors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    floors = widget.seats.keys.toList();
    selectedFloor = widget.initialFloor;
    selectedRow = widget.initialRow;
    print('selectedFloor $selectedFloor');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 층 선택 버튼
        GestureDetector(
          onTap: () => _showSelectionDialog(
            context,
            title: '층 선택',
            options: floors,
            onSelected: (value) {
              setState(() {
                selectedFloor = value;
                selectedRow = null;
                widget.onFloorSelected.call(value);
              });
            },
          ),
          child: _buildChip(selectedFloor ?? '층 선택'),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: selectedFloor == null
              ? null
              : () => _showSelectionDialog(
                    context,
                    title: '열 선택',
                    options: widget.seats[selectedFloor!] ?? [],
                    onSelected: (value) {
                      setState(() {
                        selectedRow = value;
                        widget.onRowSelected.call(value);
                      });
                    },
                  ),
          child: _buildChip(selectedRow ?? '열 선택', isDisabled: selectedFloor == null),
        ),
      ],
    );
  }

  Widget _buildChip(String text, {bool isDisabled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey.shade300 : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(text, style: AppDesign.typo.body2()),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_drop_down,
            color: isDisabled ? Colors.grey.shade500 : Colors.black,
          ),
        ],
      ),
    );
  }

  void _showSelectionDialog(
    BuildContext context, {
    required String title,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      backgroundColor: AppDesign.colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: AppDesign.typo.body1(),
              ),
            ),
            ...options.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  onSelected(option);
                  Navigator.pop(context); // 선택 후 닫기
                },
              );
            }),
            AppDesign.spacing.h24,
          ],
        );
      },
    );
  }
}
