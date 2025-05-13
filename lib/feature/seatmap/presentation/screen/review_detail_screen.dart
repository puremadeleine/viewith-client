import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:dio/dio.dart';
import 'package:viewith/di/app_providers.dart';

class ReviewDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const ReviewDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends ConsumerState<ReviewDetailScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  String _getErrorMessage(Object error) {
    if (error is DioException) {
      if (error.response?.statusCode == 401) {
        return '로그인이 필요한 기능입니다. 로그인 후 다시 시도해주세요.';
      }
      if (error.response?.statusCode == 404) {
        return '존재하지 않는 리뷰입니다.';
      }
    } else if (error is BaseError) {
      if (error.code == 401) {
        return '로그인이 필요한 기능입니다. 로그인 후 다시 시도해주세요.';
      }
      if (error.code == 404) {
        return '존재하지 않는 리뷰입니다.';
      }
      return error.message;
    }
    return '알 수 없는 에러가 발생했습니다. 잠시 후 다시 시도해주세요.';
  }

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

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(venueRepositoryProvider).fetchReview(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("리뷰 상세", style: AppDesign.typo.title2bold()),
      ),
      body: FutureBuilder<Result<Review, BaseError>>(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (_isAuthError(snapshot.error!)) {
              _handleAuthError();
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_getErrorMessage(snapshot.error!)),
                  const SizedBox(height: 16),
                  if (_isAuthError(snapshot.error!))
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(tokenHandlerProvider).clearTokens();
                        if (mounted) {
                          context.goNamed(AppRoute.signIn.name);
                        }
                      },
                      child: const Text('로그인하기'),
                    ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.match(
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_getErrorMessage(error)),
                    const SizedBox(height: 16),
                    if (_isAuthError(error))
                      ElevatedButton(
                        onPressed: () async {
                          await ref.read(tokenHandlerProvider).clearTokens();
                          if (mounted) {
                            context.goNamed(AppRoute.signIn.name);
                          }
                        },
                        child: const Text('로그인하기'),
                      ),
                  ],
                ),
              );
            },
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
            items: images.map((url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
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
