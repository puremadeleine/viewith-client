import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/vi_search_bar.dart';

class SearchScreenTemplate<T> extends ConsumerStatefulWidget {
  final String title;
  final String subTitle;
  final String searchHint;
  final List<T> items;
  final Widget Function(BuildContext, T, String) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
  final void Function(String) onSearch;
  final Widget? bottomButton;

  const SearchScreenTemplate({
    super.key,
    required this.title,
    required this.subTitle,
    required this.searchHint,
    required this.items,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.onSearch,
    this.bottomButton,
  });

  @override
  ConsumerState<SearchScreenTemplate<T>> createState() => _SearchScreenTemplateState<T>();
}

class _SearchScreenTemplateState<T> extends ConsumerState<SearchScreenTemplate<T>> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial search to show all items
    widget.onSearch('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(widget.title),
          _buildSubTitle(widget.subTitle),
          _buildSearchBar(),
          AppDesign.spacing.h12,
          _buildListView(),
          if (widget.bottomButton != null) ...[
            const Spacer(),
            widget.bottomButton!,
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(text, style: AppDesign.typo.title1());
  }

  Widget _buildSubTitle(String text) {
    return Text(text, style: AppDesign.typo.body2(color: AppDesign.colors.gray600));
  }

  Widget _buildSearchBar() {
    return VISearchBar(
      controller: _textEditingController,
      hintText: widget.searchHint,
      onChanged: (text) {
        widget.onSearch(text);
      },
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, widget.items[index], _textEditingController.text);
        },
        separatorBuilder: widget.separatorBuilder,
        itemCount: widget.items.length,
      ),
    );
  }
}
