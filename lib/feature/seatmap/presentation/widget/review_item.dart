import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

class ReviewItem extends StatelessWidget {
  final String imageUrl;
  final String concert;
  final String seat;
  final double rating;
  final String review;
  final String date;

  const ReviewItem({
    super.key,
    required this.imageUrl,
    required this.concert,
    required this.seat,
    required this.rating,
    required this.review,
    required this.date,
  });

  Widget _buildImage() {
    // 이미지 URL이 비어있거나 유효하지 않은 경우 기본 이미지 표시
    if (imageUrl.isEmpty) {
      return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: AppDesign.colors.gray200,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Icon(
          Icons.image_not_supported,
          size: 40,
          color: AppDesign.colors.gray400,
        ),
      );
    }

    // 리뷰 상세 화면과 동일한 방식으로 단순하게 처리
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      height: 120,
      width: 120,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: AppDesign.colors.gray200,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              color: AppDesign.colors.gray400,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: AppDesign.colors.gray200,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Icon(
            Icons.broken_image,
            size: 40,
            color: AppDesign.colors.gray400,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: _buildImage(),
            ),
            const SizedBox(width: 4),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(concert, style: AppDesign.typo.body3()),
                    const SizedBox(height: 2),
                    Text(seat, style: AppDesign.typo.title1()),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : index < rating
                                    ? Icons.star_half
                                    : Icons.star_border,
                            color: Colors.red,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 4),
                        Text(
                          '${rating.toStringAsFixed(1)} / 5.0',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
