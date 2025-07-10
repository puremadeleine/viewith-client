import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/data/help/response/help_list_item.dart';
import 'package:viewith/feature/help/presentation/controller/help_list_controller.dart';
import 'package:viewith/ui/app_design.dart';

class HelpListScreen extends ConsumerWidget {
  const HelpListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(helpListControllerProvider);

    return Scaffold(
      body: state.when(
        data: (items) => _buildBody(items, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(List<HelpListItem> items, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '도움말',
          style: AppDesign.typo.title2bold(),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => _buildItem(items[index], ref),
        itemCount: items.length,
      ),
    );
  }

  Widget _buildItem(HelpListItem item, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.context.pushNamed(
          AppRoute.help.name,
          pathParameters: {'id': item.helpId.toString()},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppDesign.colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppDesign.colors.gray600.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: AppDesign.typo.body4Bold(),
              ),
              Text(
                item.content,
                style: AppDesign.typo.body4(),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
