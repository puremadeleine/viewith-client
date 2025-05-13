import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:viewith/data/performance/performance_repository.dart';
import 'package:viewith/data/performance/remote/remote_performance_repository.dart';
import 'package:viewith/di/app_providers.dart';

part 'performance_repository_providers.g.dart';

@riverpod
PerformanceRepository performanceRepository(Ref ref) {
  return RemotePerformanceRepository(client(ref));
}
