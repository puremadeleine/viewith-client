import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/feature/seatmap/presentation/widget/seat_map.dart';
import 'package:viewith/feature/writing/search/controller/writing_seat_infos_controller.dart';
import 'package:viewith/data/venue/response/seat_detail.dart';

import '../../../../app/route/app_route.dart';
import '../../../../ui/app_design.dart';
import '../../../../ui/widgets/button/vi_button.dart';
import '../../../../ui/widgets/button/vi_button_type.dart';

class WritingSeatInfoScreen extends ConsumerWidget {
  final String venueId;

  const WritingSeatInfoScreen({super.key, required this.venueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(seatDetailControllerProvider(venueId));

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
    final Size screenSize = MediaQuery.of(context).size;
    final height = screenSize.height * 0.35;
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

    // 선택된 섹션에 해당하는 열 목록 가져오기
    final selectedSectionInfo = selectedSection != null ? seatDetail.firstWhere((section) => section.section == selectedSection, orElse: () => seatDetail.first) : null;
    final rows = selectedSectionInfo?.rows.map((row) => row.row.toString()).toList() ?? [];

    // 선택된 열에 해당하는 좌석 번호와 블록 정보 가져오기
    final selectedRow = ref.watch(writingSeatInfosControllerProvider)['row'];
    final selectedRowInfo =
        selectedRow != null && selectedSectionInfo != null ? selectedSectionInfo.rows.firstWhere((row) => row.row.toString() == selectedRow, orElse: () => selectedSectionInfo.rows.first) : null;
    final numbers = selectedRowInfo?.columns.map((col) => col.column.toString()).toList() ?? [];
    final blocks = selectedRowInfo?.columns.map((col) => col.block).where((block) => block != null).map((block) => block!).toSet().toList() ?? [];

    return Row(
      children: [
        Expanded(
          child: _buildDropdownButton(
            '구역',
            sections,
            selectedSection,
            (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(section: value),
          ),
        ),
        AppDesign.spacing.w8,
        Expanded(
          child: _buildDropdownButton(
            '열',
            rows,
            selectedRow,
            (value) => ref.read(writingSeatInfosControllerProvider.notifier).updateSeatInfo(row: value),
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
    );
  }

  Widget _buildDropdownButton(String label, List<String> items, String? value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 15, color: AppDesign.colors.gray400),
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
    return VIButton(
      onTap: () => context.pushNamed(AppRoute.writingPerformance.name),
      type: VIButtonType.primary,
      text: '다음',
    );
  }
}
