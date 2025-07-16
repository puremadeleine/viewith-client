import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/feature/seatmap/presentation/widget/seat_map.dart';
import 'package:viewith/feature/writing/search/controller/writing_seat_infos_controller.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';
import 'package:viewith/feature/writing/search/controller/writing_venues_controller.dart';

import '../../../../app/route/app_route.dart';
import '../../../../ui/app_design.dart';
import '../../../../ui/widgets/button/vi_button.dart';
import '../../../../ui/widgets/button/vi_button_type.dart';

class WritingSeatInfoScreen extends ConsumerWidget {
  const WritingSeatInfoScreen({super.key});

  void _showPicker(BuildContext context, String label, List<String> items, String? currentValue, Function(String?) onChanged) {
    String? tempValue = currentValue;
    if (tempValue == null && items.isNotEmpty) {
      tempValue = items[0];
    }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.systemGrey4.resolveFrom(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('취소'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('확인'),
                      onPressed: () {
                        onChanged(tempValue);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: currentValue != null ? items.indexOf(currentValue) : 0,
                  ),
                  itemExtent: 32,
                  onSelectedItemChanged: (int index) {
                    tempValue = items[index];
                  },
                  children: items.map((String item) {
                    return Center(child: Text(item));
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    final venueId = venue?.id;
    if (venueId == null) {
      return const SizedBox.shrink();
    }
    final provider = ref.watch(seatDetailControllerProvider(venueId.toString()));

    return Scaffold(
      appBar: AppBar(),
      body: provider.when(
        data: (seatDetail) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('좌석 정보를 입력해주세요'),
              _buildSubTitle('어떤 자리에서 공연을 관람하셨나요?'),
              AppDesign.spacing.h12,
              _buildSeatMap(context),
              _buildOptions(ref, seatDetail),
              const Spacer(),
              _buildNextButton(context, ref),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(text, style: AppDesign.typo.title1());
  }

  Widget _buildSubTitle(String text) {
    return Text(text, style: AppDesign.typo.body2(color: AppDesign.colors.gray600));
  }

  Widget _buildSeatMap(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height * 0.43;
    return SizedBox(
      height: height,
      child: SeatMap(
        seatmapSource: 'assets/seatmap/kspo.svg',
        mode: const SeatMapWritable(),
        onSectionSelected: (section) {},
      ),
    );
  }

  Widget _buildOptions(WidgetRef ref, List<SectionInfo> seatDetail) {
    final sections = seatDetail.map((section) => section.section).toList();
    final selectedSection = ref.watch(writingSeatInfosControllerProvider)['section'];
    final hasError = ref.watch(writingSeatInfosControllerProvider)['error'] == 'true';

    final selectedSectionInfo = selectedSection != null ? seatDetail.firstWhere((section) => section.section == selectedSection, orElse: () => seatDetail.first) : null;
    final rows = selectedSectionInfo?.rows.map((row) => row.row).toList() ?? [];

    final selectedRow = ref.watch(writingSeatInfosControllerProvider)['row'];
    final selectedRowInfo =
        selectedRow != null && selectedSectionInfo != null ? selectedSectionInfo.rows.firstWhere((row) => row.row == selectedRow, orElse: () => selectedSectionInfo.rows.first) : null;
    final numbers = selectedRowInfo?.columns.map((col) => col.column).toList() ?? [];

    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPickerButton(
                  context,
                  '구역',
                  sections,
                  selectedSection,
                  (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(section: value),
                  hasError: hasError && selectedSection == null,
                ),
              ),
              AppDesign.spacing.w8,
              Expanded(
                child: _buildPickerButton(
                  context,
                  '열',
                  rows,
                  selectedRow,
                  (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(row: value),
                  hasError: hasError && selectedRow == null,
                ),
              ),
              AppDesign.spacing.w8,
              Expanded(
                child: _buildPickerButton(
                  context,
                  '번호',
                  numbers,
                  ref.watch(writingSeatInfosControllerProvider)['number'],
                  (value) {
                    if (value != null && selectedRowInfo != null) {
                      final selectedColumn = selectedRowInfo.columns.firstWhere(
                        (col) => col.column == value,
                        orElse: () => selectedRowInfo.columns.first,
                      );
                      ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(
                            number: value,
                            block: selectedColumn.block,
                          );
                    } else {
                      ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(number: value);
                    }
                  },
                ),
              ),
              AppDesign.spacing.w8,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '블록',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppDesign.colors.gray400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ref.watch(writingSeatInfosControllerProvider)['block'] ?? '선택',
                        style: TextStyle(
                          fontSize: 16,
                          color: ref.watch(writingSeatInfosControllerProvider)['block'] != null ? Colors.black : AppDesign.colors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (hasError && (selectedSection == null || selectedRow == null))
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 4),
              child: Text(
                '구역 / 열은 필수로 선택해야 해요.',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPickerButton(BuildContext context, String label, List<String> items, String? value, Function(String?) onChanged, {bool hasError = false}) {
    return InkWell(
      onTap: items.isEmpty ? null : () => _showPicker(context, label, items, value, onChanged),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: hasError ? Colors.red : Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: hasError ? Colors.red : AppDesign.colors.gray400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value ?? '선택',
              style: TextStyle(
                fontSize: 16,
                color: value != null ? Colors.black : AppDesign.colors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, WidgetRef ref) {
    final seatInfo = ref.watch(writingSeatInfosControllerProvider);
    final selectedSection = seatInfo['section'];
    final selectedRow = seatInfo['row'];
    final isEnabled = selectedSection != null && selectedRow != null;

    return VIButton(
      onTap: isEnabled
          ? () {
              ref.read(writingSeatInfosControllerProvider.notifier).setError(false);
              context.pushNamed(AppRoute.writingPerformance.name);
            }
          : () {
              ref.read(writingSeatInfosControllerProvider.notifier).setError(true);
            },
      type: isEnabled ? VIButtonType.primary : VIButtonType.disabled,
      text: '다음',
    );
  }
}
