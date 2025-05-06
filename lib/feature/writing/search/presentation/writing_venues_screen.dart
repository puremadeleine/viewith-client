import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/writing/search/controller/writing_venues_controller.dart';
import 'package:viewith/feature/writing/search/presentation/search_list_item.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/button/vi_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';
import 'package:viewith/ui/widgets/vi_search_bar.dart';
import '../../../../data/venue/response/venue.dart';

class WritingVenuesScreen extends ConsumerStatefulWidget {
  const WritingVenuesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritingVenuesState();
}

class _WritingVenuesState extends ConsumerState<WritingVenuesScreen> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    ref.read(writingVenuesControllerProvider.notifier).searchVenues('');
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(writingVenuesControllerProvider);
    final selectedVenue = ref.watch(selectedVenueProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('공연장을 입력해주세요'),
            _buildSubTitle('어떤 공연장에서 공연을 관람하셨나요?'),
            _buildSearchBar(ref),
            if (selectedVenue != null) ...[
              AppDesign.spacing.h8,
              _buildSelectedVenue(selectedVenue),
            ],
            AppDesign.spacing.h8,
            _buildListView(searchResult),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(text, style: AppDesign.typo.title1());
  }

  Widget _buildSubTitle(String text) {
    return Text(text, style: AppDesign.typo.body2(color: AppDesign.colors.gray600));
  }

  Widget _buildSearchBar(WidgetRef ref) {
    return VISearchBar(
      controller: _textEditingController,
      hintText: '공연장 이름을 입력해주세요.',
      onChanged: (text) {
        print('text: $text');
        ref.read(writingVenuesControllerProvider.notifier).searchVenues(text);
      },
    );
  }

  Widget _buildSelectedVenue(Venue selectedVenue) {
    return Wrap(
      spacing: 4,
      children: [
        Chip(
          label: Text(
            selectedVenue.name,
            style: AppDesign.typo.body2(color: AppDesign.colors.white),
          ),
          backgroundColor: AppDesign.colors.gray900,
          deleteIcon: Icon(
            Icons.close,
            size: 18,
            color: AppDesign.colors.white,
          ),
          onDeleted: () {
            ref.read(selectedVenueProvider.notifier).select(null);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide.none,
          ),
        ),
      ],
    );
  }

  Widget _buildListView(List<Venue> venues) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final venue = venues[index];
          return InkWell(
            onTap: () {
              ref.read(selectedVenueProvider.notifier).select(venue);
            },
            child: SearchListItem(
              text: venue.name,
              subText: venue.location,
              query: _textEditingController.text,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
        itemCount: venues.length,
      ),
    );
  }

  Widget _buildNextButton() {
    final selectedVenue = ref.watch(selectedVenueProvider);
    return VIButton(
      onTap: () {
        if (selectedVenue != null) {
          context.pushNamed(
            AppRoute.writingSeatInfo.name,
            pathParameters: {'id': selectedVenue.id.toString()},
          );
        }
      },
      type: selectedVenue != null ? VIButtonType.primary : VIButtonType.disabled,
      text: '다음',
    );
  }
}
