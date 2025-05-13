import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    print("Watched venue in WritingSeatInfoScreen: $venue");
    print("Venue ID: ${venue?.id}, Name: ${venue?.name}");
    final venueId = venue?.id;
    if (venueId == null) {
      print("Venue ID is null, returning empty widget");
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

    // 선택된 섹션에 해당하는 열 목록 가져오기
    final selectedSectionInfo = selectedSection != null ? seatDetail.firstWhere((section) => section.section == selectedSection, orElse: () => seatDetail.first) : null;
    final rows = selectedSectionInfo?.rows.map((row) => row.row.toString()).toList() ?? [];

    // 선택된 열에 해당하는 좌석 번호와 블록 정보 가져오기
    final selectedRow = ref.watch(writingSeatInfosControllerProvider)['row'];
    final selectedRowInfo =
        selectedRow != null && selectedSectionInfo != null ? selectedSectionInfo.rows.firstWhere((row) => row.row.toString() == selectedRow, orElse: () => selectedSectionInfo.rows.first) : null;
    final numbers = selectedRowInfo?.columns.map((col) => col.column.toString()).toList() ?? [];
    final blocks = selectedRowInfo?.columns.map((col) => col.block).where((block) => block != null).map((block) => block!).toSet().toList() ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDropdownButton(
                '구역',
                sections,
                selectedSection,
                (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(section: value),
                hasError: hasError && selectedSection == null,
              ),
            ),
            AppDesign.spacing.w8,
            Expanded(
              child: _buildDropdownButton(
                '열',
                rows,
                selectedRow,
                (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(row: value),
                hasError: hasError && selectedRow == null,
              ),
            ),
            AppDesign.spacing.w8,
            Expanded(
              child: _buildDropdownButton(
                '번호',
                numbers,
                ref.watch(writingSeatInfosControllerProvider)['number'],
                (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(number: value),
              ),
            ),
            AppDesign.spacing.w8,
            Expanded(
              child: _buildDropdownButton(
                '블록',
                blocks,
                ref.watch(writingSeatInfosControllerProvider)['block'],
                (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(block: value),
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
    );
  }

  Widget _buildDropdownButton(String label, List<String> items, String? value, Function(String?) onChanged, {bool hasError = false}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 15, color: hasError ? Colors.red : AppDesign.colors.gray400),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
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
