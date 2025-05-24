sealed class Result<T> {}

class Success<T> extends Result<T> {
  final String? message;
  final T? data;
  Success({this.message, this.data});
}

class Failure<T> extends Result<T> {
  final String message;
  final int? statusCode;
  Failure({
    required this.message,
    this.statusCode,
  });
}
