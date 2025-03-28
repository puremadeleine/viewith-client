import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/data/venue/response/review.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:dio/dio.dart';

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_getErrorMessage(snapshot.error!)),
                  const SizedBox(height: 16),
                  if (_isAuthError(snapshot.error!))
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to login screen
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
            onFailure: (error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_getErrorMessage(error)),
                  const SizedBox(height: 16),
                  if (_isAuthError(error))
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to login screen
                      },
                      child: const Text('로그인하기'),
                    ),
                ],
              ),
            ),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                RatingBarIndicator(
                  rating: review.rating,
                  itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 18.0,
                ),
                const SizedBox(width: 8),
                Text("${review.rating} / 5.0", style: const TextStyle(fontSize: 14)),
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
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("좌석이 마음에 드셨나요?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            "관심있는 좌석을 즐겨찾기 해보세요. 마이페이지 > 즐겨찾기 한 후기를 통해 한 번에 모아볼 수 있어요.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildTagButton(review.seatRawData.section),
              const SizedBox(width: 8),
              _buildTagButton("${review.seatRawData.row}열"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}
