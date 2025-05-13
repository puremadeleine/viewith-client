import 'package:viewith/core/result/api_response_parser.dart';
import 'package:viewith/core/result/base_error.dart';
import 'package:viewith/core/result/result.dart';
import 'package:viewith/data/performance/performance_repository.dart';
import 'package:viewith/data/performance/response/performance.dart';
import 'package:viewith/network/client.dart';

class RemotePerformanceRepository extends PerformanceRepository {
  final Client _client;

  RemotePerformanceRepository(this._client);

  @override
  Future<Result<List<Performance>, BaseError>> searchPerformances(String keyword) async {
    final response = await _client.get(
      '/v1/performances/search',
      queryParameters: {'keyword': keyword},
    );

    return response.toListResult(fromJson: Performance.fromJson, key: 'performances');
  }
}
