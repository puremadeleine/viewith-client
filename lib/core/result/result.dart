sealed class Result<S, F> {
  const Result();

  T match<T>({
    required T Function(S success) onSuccess,
    required T Function(F failure) onFailure,
  });

  S? get successValue {
    return switch (this) {
      Success(value: final value) => value,
      Failure() => null,
    };
  }

  static Result<List<S>, F> combine<S, F>(List<Result>? results) {
    if (results == null || results.isEmpty) {
      return const Success([]);
    }

    final successResults = <S>[];
    for (final result in results) {
      final matches = result.match(
        onSuccess: (success) {
          successResults.add(success);
          return true;
        },
        onFailure: (failure) => false,
      );

      if (!matches) {
        return Failure(result.match(
          onSuccess: (_) => throw Exception('Unreachable'),
          onFailure: (f) => f,
        ));
      }
    }

    return Success(successResults);
  }
}

final class Success<S, F> extends Result<S, F> {
  const Success(this.value);

  final S value;

  @override
  T match<T>({
    required T Function(S success) onSuccess,
    required T Function(F failure) onFailure,
  }) {
    return onSuccess(value);
  }
}

final class Failure<S, F> extends Result<S, F> {
  const Failure(this.error);

  final F error;

  @override
  T match<T>({
    required T Function(S success) onSuccess,
    required T Function(F failure) onFailure,
  }) {
    return onFailure(error);
  }
}
