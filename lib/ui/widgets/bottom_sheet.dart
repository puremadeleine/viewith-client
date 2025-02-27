import 'package:flutter/widgets.dart';
import 'package:viewith/core/utils/text_span.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/foundation/spacing.dart';

class VIBottomSheet<T> extends StatelessWidget {
  final ScrollController controller;
  final Widget widget;
  final List<T> items;
  final Function(T) onItemSelected;
  final Widget Function(BuildContext)? titleBuilder;
  final Widget Function(BuildContext, T) itemBuilder;

  const VIBottomSheet({
    super.key,
    required this.controller,
    required this.widget,
    required this.items,
    required this.onItemSelected,
    this.titleBuilder,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      decoration: BoxDecoration(
        color: AppDesign.colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: AppDesign.colors.gray200,
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleBuilder != null) titleBuilder!(context),
          if (titleBuilder != null) AppDesign.spacing.h24,
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    Widget buildEmptyView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('조건에 일치하는 후기가 없어요.', style: AppDesign.typo.title1(),),
          AppDesign.spacing.h8,
          Text.rich(
            TextSpan(
              children: styledText([
                ('관심있는 좌석을 즐겨찾기 해보세요.\n'),
                ('마이페이지 > 즐겨찾기 한 후기', FontWeight.bold),
                ('를 통해\n한 번에 모아볼 수 있어요.'),
              ]),
            ),
          )
        ],
      );
    }

    if (items.isEmpty) {
      return buildEmptyView();
    }

    return Flexible(
      child: ListView.separated(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemSelected(items[index]);
            },
            child: itemBuilder(context, items[index]),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
