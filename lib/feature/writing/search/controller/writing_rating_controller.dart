import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'writing_rating_controller.g.dart';

@riverpod
class WritingRating extends _$WritingRating {
  @override
  double build() {
    return 0.0;
  }

  void updateRating(double rating) {
    print('🎯 별점 업데이트: $rating'); // 디버그 로그
    state = rating;
  }
}
