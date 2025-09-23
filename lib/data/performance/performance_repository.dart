import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/performance/response/performance.dart';

abstract class PerformanceRepository {
  Future<Result<List<Performance>, BaseError>> searchPerformances(String keyword, String venueId);
}
