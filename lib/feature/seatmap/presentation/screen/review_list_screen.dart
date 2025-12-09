import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/data/venue/request/review_params.dart';
import 'package:viewith/data/venue/response/venue_detail.dart';
import 'package:viewith/feature/seatmap/presentation/controller/review_list_controller.dart';
import 'package:viewith/feature/seatmap/presentation/controller/state/review_list_state.dart';
import 'package:viewith/feature/seatmap/presentation/widget/floor_row_selector.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/bottom_sheet.dart';
import 'package:viewith/ui/widgets/button/vi_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';
import 'package:viewith/ui/widgets/chip_list.dart';

import '../../../../core/utils/svg_util.dart';
import '../../../../data/venue/response/review.dart';
import '../../../../ui/gen/assets.gen.dart';
import '../widget/review_item.dart';
import '../widget/seat_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:viewith/ui/widgets/custom_toggle_switch.dart';
import 'package:viewith/ui/widgets/dialog/guest_dialog.dart';
import 'package:viewith/ui/widgets/error_widget.dart' as error_widget;
import 'package:viewith/di/app_providers.dart';

class ReviewListScreen extends ConsumerStatefulWidget {
  final String id;
  final String venueName;

  const ReviewListScreen({super.key, required this.id, required this.venueName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends ConsumerState<ReviewListScreen> {
  double _minChildSize = 0.3;
  bool _isFilterMode = false;
  final _draggableController = DraggableScrollableController();
  double _availableHeight = 0;
  bool _isStageToggleOn = false;
  String? _selectedStageUrl;
  String? _selectedStageName;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _draggableController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _calculateMinChildSize();
  }

  Future<void> _calculateMinChildSize() async {
    final Size screenSize = MediaQuery.of(context).size;
    final Size svgSize = await SvgUtil.getSize(context, 'assets/seatmap/kspo.svg');
    double scaledHeight = screenSize.width * (svgSize.height / svgSize.width);
    scaledHeight += 30;
    _availableHeight = screenSize.height - kToolbarHeight;
    _minChildSize = 1 - (scaledHeight / _availableHeight);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reviewListControllerProvider(widget.id));
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppDesign.colors.gray100,
      body: state.when(
        data: (data) => Stack(
          children: [
            _buildSeatMap(data.venueInfo),
            Positioned(
              top: 10,
              right: 10,
              child: CustomToggleSwitch(
                text: '무대 오버레이',
                value: _isStageToggleOn,
                onChanged: _onStageToggleChanged,
              ),
            ),
             _buildBottomSheet(data),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => error_widget.ErrorWidget(
          error: error_widget.mapExceptionToError(err),
          onRetry: () => ref.invalidate(reviewListControllerProvider(widget.id)),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.venueName,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            AppDesign.spacing.w4,
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.helpList.name);
              },
              child: Assets.images.infoFill.svg(),
            ),
          ],
        ),
      ),
      backgroundColor: AppDesign.colors.white,
      centerTitle: true,
    );
  }

  Widget _buildSeatMap(AsyncValue<VenueDetail> venueDetail) {
    final value = venueDetail.value;
    if (venueDetail.isLoading) {
      return const CircularProgressIndicator();
    }

    if (value == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SeatMap(
        seatmapSource: value.seatmapUrl,
        stageSource: _selectedStageUrl,
        sourceType: SvgSource.url,
        mode: SeatMapReadOnly(reviewCount: value.sectionReviewCountMap),
        onSectionSelected: (id) {
          // id에서 섹션 정보 추출 (예: "SEAT_B1" -> "B1", "FLOOR_B" -> "B")
          final sectionMatch = RegExp(r'(?:SEAT_|FLOOR_)([A-Z0-9]+)(?:_TEXT)?').firstMatch(id);
          if (sectionMatch != null) {
            final section = sectionMatch.group(1);
            if (section != null) {
              // sectionReviewCountMap에서 해당 섹션의 리뷰 갯수 확인
              // 전체 id 형식("SEAT_B1", "FLOOR_B") 또는 섹션만("B1", "B")으로 확인
              final reviewCount = value.sectionReviewCountMap[id] ?? 
                                  value.sectionReviewCountMap[section] ?? 0;
              
              // 리뷰 갯수가 1 이상인 경우에만 필터 적용
              if (reviewCount >= 1) {
                ref.read(reviewListControllerProvider(widget.id).notifier).setSection(section);
              } else {
                // 빈 구역인 경우 토스트 메시지 표시
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '아직 작성된 후기가 없어요.',
                      style: AppDesign.typo.body2(color: AppDesign.colors.white),
                    ),
                    backgroundColor: AppDesign.colors.gray900,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  Widget _buildBottomSheet(ReviewListState state) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        controller: _draggableController,
        initialChildSize: _minChildSize,
        minChildSize: _minChildSize,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return _isFilterMode
              ? _buildFilterScreen(state.seats, state.selectedFloor, state.selectedRow, scrollController)
              : _buildReviews(state.reviews.value ?? [], scrollController);
        },
      ),
    );
  }

  void _onStageToggleChanged(bool value) {
    setState(() {
      _isStageToggleOn = value;
      if (_isStageToggleOn) {
        final stages = ref.read(reviewListControllerProvider(widget.id)).value?.venueInfo.value?.stages;
        if (stages != null && stages.isNotEmpty) {
          _showStageSelectionBottomSheet(stages);
        }
      } else {
        _selectedStageUrl = null;
        _selectedStageName = null;
      }
    });
  }

  void _showStageSelectionBottomSheet(List<Stage> stages) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppDesign.colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('📌 무대 오버레이란?', style: AppDesign.typo.h2()),
                    ],
                  ),
                  AppDesign.spacing.h8,
                  Text(
                    '플로어 구역의 경우 무대 연출에 따라 매번 달라지기 때문에\nviewith에서 임의로 플로어 구역을 나누었어요.\n배치도 위에 무대를 겹쳐보며 어떤 구역의 후기를 볼 지 결정해보세요.',
                    style: AppDesign.typo.body2(),
                  ),
                  AppDesign.spacing.h20,
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: stages.length,
                    itemBuilder: (context, index) {
                      final stage = stages[index];
                      return ListTile(
                        leading: SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRect(
                            child: Transform.scale(
                              scale: 2.0,
                              child: SvgPicture.network(
                                stage.svgUrl,
                                placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        title: Text(stage.name, style: AppDesign.typo.body1()),
                        onTap: () {
                          setState(() {
                            _selectedStageUrl = stage.svgUrl;
                            _selectedStageName = stage.name;
                            _isStageToggleOn = true;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (_selectedStageUrl == null) {
        setState(() {
          _isStageToggleOn = false;
        });
      }
    });
  }

  Widget _buildReviews(List<Review> reviews, ScrollController scrollController) {
    final reviewListState = ref.watch(reviewListControllerProvider(widget.id)).value;
    final reviewListNotifier = ref.read(reviewListControllerProvider(widget.id).notifier);

    return VIBottomSheet<Review>(
      controller: scrollController,
      widget: widget,
      items: reviews,
      onItemSelected: (item) {
        // 비회원 체크
        final isGuest = ref.read(isGuestModeProvider);
        if (isGuest) {
          showGuestDialog(context, ref);
        } else {
          context.push(
            '${AppRoute.reviewDetail.path}/${item.reviewId}',
            extra: {
              'venueId': widget.id,
            },
          );
        }
      },
      titleBuilder: (context) => Row(
        children: [
          _buildFilterButton(),
          const SizedBox(width: 8),
          Expanded(
            child: ChipList(
              chips: reviewListState?.filterChips ?? [],
              onRemove: (chip) {
                reviewListNotifier.removeFilterChip(chip);
              },
            ),
          ),
        ],
      ),
      itemBuilder: (context, review) {
        // 좌석 정보를 문자열로 조합
        final seatInfo = '${review.seatRawData.floor}층 ${review.seatRawData.section}구역 ${review.seatRawData.row}열 ${review.seatRawData.column}번';
        
        return ReviewItem(
          imageUrl: review.imageList.isNotEmpty ? review.imageList.first : '',
          concert: "공연명", // TODO: 실제 공연명 데이터가 필요할 경우 추가
          seat: seatInfo,
          rating: review.rating,
          review: review.content,
          date: review.createdAt,
        );
      },
    );
  }

  Widget _buildFilterButton() {
    return GestureDetector(
      onTap: () {
        _openFilterMode();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppDesign.colors.gray900,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Assets.images.candlestickLight.svg(),
      ),
    );
  }

  Widget _buildFilterScreen(Map<String, List<String>> seats, String? initialFloor, String? initialRow, ScrollController scrollController) {
    return Container(
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
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: _closeFilterMode),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _buildSortOptions(),
                          AppDesign.spacing.h8,
                          _buildSeatOptions(seats, initialFloor, initialRow),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSortOptions() {
    final sortOption = ref.watch(reviewListControllerProvider(widget.id).select((state) => state.value?.sortType));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("정렬", style: AppDesign.typo.h2()),
        AppDesign.spacing.h8,
        Container(
          height: 1.0,
          color: AppDesign.colors.gray200,
        ),
        AppDesign.spacing.h8,
        Wrap(
          spacing: 10,
          children: ReviewSortType.values.map((option) {
            final color = option == sortOption ? AppDesign.colors.white : AppDesign.colors.gray900;
            return ChoiceChip(
              label: Text(option.name, style: AppDesign.typo.body2(color: color)),
              selected: option == sortOption,
              selectedColor: AppDesign.colors.gray900,
              checkmarkColor: color,
              onSelected: (selected) {
                if (selected) {
                  ref.read(reviewListControllerProvider(widget.id).notifier).setSortOption(option);
                }
              },
              showCheckmark: false,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSeatOptions(Map<String, List<String>> seats, String? initialFloor, String? initialRow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("좌석", style: AppDesign.typo.h2()),
        AppDesign.spacing.h8,
        Container(
          height: 1.0,
          color: AppDesign.colors.gray200,
        ),
        AppDesign.spacing.h8,
        FloorRowSelector(
          seats: seats,
          onFloorSelected: (String floor) {
            ref.read(reviewListControllerProvider(widget.id).notifier).setFloor(floor);
          },
          onRowSelected: (String row) {
            ref.read(reviewListControllerProvider(widget.id).notifier).setRow(row);
          },
          initialFloor: initialFloor,
          initialRow: initialRow,
        ),
      ],
    );
  }

  // 기능 필요 시 추가
  Widget _buildBottomButtons() {
    Widget buildResetButton() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          '필터 초기화',
          style: AppDesign.typo.body1Bold(),
        ),
      );
    }

    Widget buildSaveButton() {
      return VIButton(
        onTap: () {},
        type: VIButtonType.primary,
        text: '필터 저장하기',
        padding: AppDesign.spacing.buttonPadding,
      );
    }

    return Row(
      children: [
        buildResetButton(),
        const Spacer(),
        buildSaveButton(),
      ],
    );
  }

  void _openFilterMode() {
    setState(() {
      _isFilterMode = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_availableHeight > 0) {
        final targetSize = _draggableController.size + (40 / _availableHeight);
        _draggableController.animateTo(
          targetSize.clamp(_minChildSize, 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _closeFilterMode() {
    _draggableController
        .animateTo(
      _minChildSize,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      if (mounted) {
        setState(() {
          ref.read(reviewListControllerProvider(widget.id).notifier).fetchReviews();
          _isFilterMode = false;
        });
      }
    });
  }
}
