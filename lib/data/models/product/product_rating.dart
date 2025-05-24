import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_rating.freezed.dart';
part 'product_rating.g.dart';

@freezed
abstract class Rating with _$Rating {
  /// Creates a [Rating] instance.
  ///
  /// [rate]: The rating value (e.g., 3.9).
  /// [count]: The number of ratings (e.g., 120).
  const factory Rating({
    required double rate,
    required int count,
  }) = _Rating;

  /// Creates a [Rating] instance from a JSON object.
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
