import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/data/help/response/help_list_item.dart';
import 'package:viewith/feature/help/presentation/controller/help_controller.dart';
import 'package:viewith/ui/widgets/button/vi_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';

import '../../../ui/app_design.dart';

class HelpDetailScreen extends ConsumerWidget {
  const HelpDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(helpControllerProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '도움말',
          style: AppDesign.typo.title2bold(),
        ),
        centerTitle: true,
      ),
      body: state.when(
        data: (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildBody(item),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(HelpListItem item) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(item.title, style: AppDesign.typo.title1ExtraBold()),
          ),
          Html(
            data: item.content,
            style: {
              "body": Style(
                fontSize: FontSize(16.0),
                color: AppDesign.colors.gray900,
              ),
            },
          ),
          AppDesign.spacing.h48,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSurvey(),
          ),
        ],
      ),
    );
  }

  Widget _buildSurvey() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '답변이 마음에 드셨나요?\n잘못된 정보가 있다면 꼭 알려주세요.',
          style: AppDesign.typo.h2(),
        ),
        AppDesign.spacing.h8,
        SizedBox(
          width: 250,
          child: VIButton(onTap: () {}, type: VIButtonType.primary, text: '📮 잘못된 정보가 있어요'),
        ),
        AppDesign.spacing.h8,
      ],
    );
  }
}
