import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/venue/venue_repository_providers.dart';

part 'writing_review_controller.g.dart';

@riverpod
class WritingReview extends _$WritingReview {
  @override
  Future<void> build() async {}

  Future<void> submitReview({
    required int venueId,
    required String section,
    required int seatRow,
    int? seatColumn,
    required String content,
    required double rating,
    List<String>? images,
  }) async {
    final repository = ref.read(venueRepositoryProvider);
    final result = await repository.createReview(
      venueId: venueId,
      section: section,
      seatRow: seatRow,
      seatColumn: seatColumn,
      content: content,
      rating: rating,
      images: images,
    );

    return result.match(
      onSuccess: (_) {},
      onFailure: (error) => throw error,
    );
  }
}
