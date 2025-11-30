import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:dio/dio.dart';
import 'package:viewith/di/app_providers.dart';
import 'package:viewith/core/providers/current_user_provider.dart';
import 'package:viewith/data/venue/request/report_reason.dart';
import 'package:viewith/data/venue/request/report_review_request.dart';
import 'package:viewith/feature/seatmap/presentation/controller/review_detail_controller.dart';
import 'package:viewith/feature/seatmap/presentation/controller/review_list_controller.dart';
import 'package:viewith/feature/profile/presentation/screen/written_reviews_screen.dart';
import 'package:viewith/ui/widgets/error_widget.dart' as error_widget;

class ReviewDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const ReviewDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends ConsumerState<ReviewDetailScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  bool _isAuthError(Object error) {
    if (error is DioException) {
      return error.response?.statusCode == 401;
    } else if (error is BaseError) {
      return error.code == 401;
    }
    return false;
  }

  Future<void> _handleAuthError() async {
    await ref.read(tokenHandlerProvider).clearTokens();
    if (mounted) {
      context.goNamed(AppRoute.signIn.name);
    }
  }

  void _showActionSheet(BuildContext context, int? currentUserId, Review review) {
    final isMyReview = currentUserId == review.userInfo.userId;
    
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          if (isMyReview) // 내 리뷰인 경우 삭제 버튼
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteDialog(context);
              },
              child: Text(
                '삭제',
                style: AppDesign.typo.body1SemiBold(color: AppDesign.colors.red900),
              ),
            ),
          if (!isMyReview) // 다른 사람의 리뷰인 경우 신고 버튼
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _showReportDialog(context);
              },
              child: Text(
                '신고',
                style: AppDesign.typo.body1SemiBold(color: AppDesign.colors.red900),
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            '취소',
            style: AppDesign.typo.body2(),
          ),
        ),
      ),
    );
  }


  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '정말 삭제하시겠어요?',
              style: AppDesign.typo.title2bold(color: AppDesign.colors.gray900),
            ),
          ),
          content: Text(
            '삭제 후 정보는 복구할 수 없어요.\n정말로 삭제하시겠습니까?',
            style: AppDesign.typo.body1(color: AppDesign.colors.gray900),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              child: Text(
                '취소',
                style: AppDesign.typo.body1(color: AppDesign.colors.gray600),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                '삭제',
                style: AppDesign.typo.body1SemiBold(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: AppDesign.colors.white,
        );
      },
    );

    if (confirmed == true) {
      await _deleteReview();
    }
  }

  Future<void> _showReportDialog(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ReportBottomSheet(
        onReport: (reason, detail) => _reportReview(reason, detail),
      ),
    );
  }

  Future<void> _deleteReview() async {
    try {
      final repository = ref.read(venueRepositoryProvider);
      final result = await repository.deleteReview(widget.id);
      
      result.match(
        onSuccess: (_) {
          if (mounted) {
            // 리뷰 리스트 업데이트 - 모든 venue의 리뷰 리스트를 무효화
            ref.invalidate(reviewListControllerProvider);
            // 내가 작성한 리뷰 목록도 업데이트
            ref.invalidate(writtenReviewsProvider);
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('리뷰가 삭제되었습니다.')),
            );
            context.pop();
          }
        },
        onFailure: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('삭제 실패: ${error.message}')),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('삭제 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  Future<void> _reportReview(ReportReason reason, String? detail) async {
    try {
      final repository = ref.read(venueRepositoryProvider);
      final request = ReportReviewRequest(
        reportReason: reason.value,
        reportReasonDetail: detail,
      );
      final result = await repository.reportReview(widget.id, request);
      
      result.match(
        onSuccess: (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('신고가 접수되었습니다.')),
            );
          }
        },
        onFailure: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('신고 실패: ${error.message}')),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('신고 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(reviewDetailProvider(widget.id));
    final currentUserId = ref.watch(currentUserProvider);
    
    // GoRouterState에서 extra 정보 확인
    final goRouterState = GoRouterState.of(context);
    final extra = goRouterState.extra as Map<String, dynamic>?;
    final fromHome = extra?['fromHome'] == true;

    return Scaffold(
      appBar: AppBar(
        title: Text("리뷰 상세", style: AppDesign.typo.title2bold()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (fromHome) {
              // 홈에서 온 경우 홈으로 이동
              context.go(AppRoute.home.path);
            } else {
              // 일반적인 뒤로가기
              context.pop();
            }
          },
        ),
        actions: [
          // 로그인한 사용자만 햄버거 메뉴 표시
          if (currentUserId.value != null)
            response.when(
              data: (result) => result.match(
                onSuccess: (review) {
                  final isMyReview = currentUserId.value == review.userInfo.userId;
                  // 메뉴 아이템이 있는 경우에만 버튼 표시
                  if (isMyReview || currentUserId.value != null) {
                    return IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => _showActionSheet(context, currentUserId.value, review),
                    );
                  }
                  return const SizedBox.shrink();
                },
                onFailure: (_) => const SizedBox.shrink(),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
        ],
      ),
      body: response.when(
        data: (result) => result.match(
          onSuccess: (review) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfo(review),
                  if (review.imageList.isNotEmpty) _buildImageSlider(review.imageList),
                  _buildReviewContent(review),
                  AppDesign.spacing.h16,
                  _buildFavoriteSection(review),
                ],
              ),
            ),
          ),
          onFailure: (error) {
            if (_isAuthError(error)) {
              _handleAuthError();
            }
            return error_widget.ErrorWidget(
              error: error,
              customMessage: _isAuthError(error) 
                  ? '로그인이 필요한 기능입니다.\n로그인 후 다시 시도해주세요.'
                  : null,
              onRetry: _isAuthError(error)
                  ? () async {
                      await ref.read(tokenHandlerProvider).clearTokens();
                      if (mounted) {
                        context.goNamed(AppRoute.signIn.name);
                      }
                    }
                  : () => ref.invalidate(reviewDetailProvider(widget.id)),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          final baseError = error_widget.mapExceptionToError(error);
          final isAuthError = _isAuthError(error);
          
          if (isAuthError) {
            _handleAuthError();
          }
          
          return error_widget.ErrorWidget(
            error: baseError,
            customMessage: isAuthError
                ? '로그인이 필요한 기능입니다.\n로그인 후 다시 시도해주세요.'
                : null,
            onRetry: isAuthError
                ? () async {
                    await ref.read(tokenHandlerProvider).clearTokens();
                    if (mounted) {
                      context.goNamed(AppRoute.signIn.name);
                    }
                  }
                : () => ref.invalidate(reviewDetailProvider(widget.id)),
          );
        },
      ),
    );
  }

  Widget _buildUserInfo(Review review) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.userInfo.userNickname,
              style: AppDesign.typo.body1Bold(),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                RatingBarIndicator(
                  rating: review.rating,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: AppDesign.colors.red900,
                  ),
                  itemCount: 5,
                  itemSize: 18.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  unratedColor: AppDesign.colors.gray300,
                ),
                const SizedBox(width: 8),
                Text("${review.rating} / 5.0", style: AppDesign.typo.body2Bold()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSlider(List<String> images) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: images.asMap().entries.map((entry) {
              final index = entry.key;
              final url = entry.value;
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FullscreenImageViewer(
                        images: images,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: 24,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${_currentIndex + 1} / ${images.length}",
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewContent(Review review) {
    return Text(
      review.content,
      style: const TextStyle(fontSize: 14, height: 1.6),
    );
  }

  Widget _buildFavoriteSection(Review review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppDesign.colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppDesign.colors.gray900),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("좌석이 마음에 드셨나요?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            "관심있는 좌석을 즐겨찾기 해보세요. 마이페이지 > 즐겨찾기 한 후기를 통해 한 번에 모아볼 수 있어요.",
            style: TextStyle(fontSize: 14, color: AppDesign.colors.gray900),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTagButton("${review.seatRawData.floor}층 ${review.seatRawData.row}열", review.bookmarkInfo?.bookmarked ?? false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagButton(String label, bool bookmarked) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppDesign.colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppDesign.colors.gray600),
      ),
      child: Row(
        children: [
          _buildBookmarkButton(bookmarked),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildBookmarkButton(bool bookmarked) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement bookmark toggle
      },
      child: Icon(
        bookmarked ? Icons.bookmark : Icons.bookmark_border,
        size: 16,
      ),
    );
  }
}

class FullscreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullscreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: AppDesign.typo.body1Bold(color: Colors.white),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final url = widget.images[index];
          return Center(
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              child: Image.network(
                url,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReportBottomSheet extends StatefulWidget {
  final Function(ReportReason reason, String? detail) onReport;

  const _ReportBottomSheet({required this.onReport});

  @override
  State<_ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<_ReportBottomSheet> {
  ReportReason? _selectedReason;
  final TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 핸들 바
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // 제목
            Center(
              child: Text(
                '신고하기',
                style: AppDesign.typo.h3(),
              ),
            ),
            const SizedBox(height: 16),

            Divider(
              color: AppDesign.colors.gray200,
              height: 1,
            ),
            const SizedBox(height: 16),
            
            // 신고 사유 선택
            Text(
              '신고 사유',
              style: AppDesign.typo.h3(),
            ),
            
            // 라디오 버튼들
            ...ReportReason.values.map((reason) => RadioListTile<ReportReason>(
              title: Text(
                reason.displayName,
                style: AppDesign.typo.body2(),
              ),
              value: reason,
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                  // OTHER가 아닌 경우 텍스트 필드 초기화
                  if (value != ReportReason.other) {
                    _detailController.clear();
                  }
                });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              dense: true,
              visualDensity: VisualDensity.compact,
            )),
            
            // 상세 사유 입력 (OTHER 선택 시에만 표시)
            if (_selectedReason == ReportReason.other) ...[
              const SizedBox(height: 16),
              Text(
                '상세 사유',
                style: AppDesign.typo.h3(),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _detailController,
                decoration: InputDecoration(
                  hintText: '신고 사유를 입력해주세요.',
                  hintStyle: AppDesign.typo.body2(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppDesign.colors.gray900),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                maxLines: 4,
                style: AppDesign.typo.body2(),
                onChanged: (value) {
                  setState(() {}); // 버튼 상태 업데이트를 위해
                },
              ),
            ],
            
            const SizedBox(height: 32),
            
            // 완료 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _canSubmit() ? _handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canSubmit() 
                      ? AppDesign.colors.gray900 
                      : AppDesign.colors.gray400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '완료',
                  style: AppDesign.typo.body1Bold(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canSubmit() {
    if (_selectedReason == null) return false;
    
    // OTHER 선택 시 상세 사유가 필수
    if (_selectedReason == ReportReason.other) {
      return _detailController.text.trim().isNotEmpty;
    }
    
    // OTHER가 아닌 경우 사유만 선택하면 됨
    return true;
  }

  void _handleSubmit() {
    if (_selectedReason == null) return;
    
    String? detail;
    if (_selectedReason == ReportReason.other) {
      detail = _detailController.text.trim();
      if (detail.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('기타 선택 시 상세 사유를 입력해주세요.')),
        );
        return;
      }
    }
    
    widget.onReport(_selectedReason!, detail);
    Navigator.of(context).pop();
  }
}
