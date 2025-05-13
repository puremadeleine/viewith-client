import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'writing_rating_controller.g.dart';

@riverpod
class WritingRating extends _$WritingRating {
  double _rating = 0.0;

  @override
  double build() {
    return _rating;
  }

  void updateRating(double rating) {
    _rating = rating;
    state = rating;
  }

  
}
