import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/performance/response/performance.dart';
import 'package:viewith/data/performance/performance_repository_providers.dart';

part 'writing_performances_controller.g.dart';

@riverpod
class WritingPerformancesController extends _$WritingPerformancesController {
  Timer? _debounce;

  @override
  List<Performance> build() {
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return [];
  }

  Future<List<Performance>> searchPerformances(String keyword, String venueId) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    return Future.delayed(const Duration(milliseconds: 300), () async {
      final result = await ref.read(performanceRepositoryProvider).searchPerformances(keyword, venueId);
      return result.match(
        onSuccess: (performances) {
          state = performances;
          return performances;
        },
        onFailure: (error) => throw error,
      );
    });
  }

  void selectPerformance(Performance performance) {
    state = state.where((p) => p == performance).toList();
  }
}
