import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';
import 'package:viewith/ui/app_design.dart';

class ReviewDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const ReviewDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ReviewDetailScreen> createState() => _ReviewDetailScreenState();
}

class _ReviewDetailScreenState extends ConsumerState<ReviewDetailScreen> {
  final List<String> imageUrls = [
    'https://tkfile.yes24.com/upload2/PerfBlog/202409/20240927/20240927-51057.jpg',
    'https://tkfile.yes24.com/upload2/PerfBlog/202409/20240927/20240927-51057.jpg',
    'https://tkfile.yes24.com/upload2/PerfBlog/202409/20240927/20240927-51057.jpg',
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _fetchReviewData();
  }

  Future<void> _fetchReviewData() async {
    final response = await ref.read(venueRepositoryProvider).fetchReview(widget.id);
    response.match(
      onSuccess: (data) {
        print(data);
      },
      onFailure: (error) {
        print(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2구역 5열 03번", style: AppDesign.typo.title2bold()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConcertInfo(),
              AppDesign.spacing.h16,
              _buildUserInfo(),
              if (imageUrls.isNotEmpty) _buildImageSlider(),
              _buildReviewContent(),
              AppDesign.spacing.h16,
              _buildFavoriteSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConcertInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.network(
            "https://tkfile.yes24.com/upload2/PerfBlog/202409/20240927/20240927-51057.jpg",
            width: 30,
            fit: BoxFit.cover,
          ),
          AppDesign.spacing.w12,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "THE BOYZ WORLD TOUR : ZENERATION IIdasdasd",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("2024.07.12 - 2024.07.14", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            "https://tkfile.yes24.com/upload2/PerfBlog/202409/20240927/20240927-51057.jpg",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("1열 사수 다람쥐", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                RatingBarIndicator(
                  rating: 4.0,
                  itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 18.0,
                ),
                const SizedBox(width: 8),
                const Text("4.0 / 5.0", style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
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
            items: imageUrls.map((url) {
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
              "${_currentIndex + 1} / ${imageUrls.length}",
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewContent() {
    return const Text(
      "너무 잘 보여요 ㅠㅠ 너무 잘 보여요 ㅠㅠ너무 잘 보여요 ㅠㅠ 너무 잘 보여요 ㅠㅠ 너무 잘 보여요 ㅠㅠ너무 잘 보여요 ㅠㅠ너무 잘 보여요 ㅠㅠ너무 잘 보여요 ㅠㅠ 너무 잘 보여요 ㅠㅠ",
      style: TextStyle(fontSize: 14, height: 1.6),
    );
  }

  Widget _buildFavoriteSection() {
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
              _buildTagButton("2구역"),
              const SizedBox(width: 8),
              _buildTagButton("2구역 5열"),
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
