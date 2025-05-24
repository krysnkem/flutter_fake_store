// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Rating {
  double get rate;
  int get count;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RatingCopyWith<Rating> get copyWith =>
      _$RatingCopyWithImpl<Rating>(this as Rating, _$identity);

  /// Serializes this Rating to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Rating &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rate, count);

  @override
  String toString() {
    return 'Rating(rate: $rate, count: $count)';
  }
}

/// @nodoc
abstract mixin class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) _then) =
      _$RatingCopyWithImpl;
  @useResult
  $Res call({double rate, int count});
}

/// @nodoc
class _$RatingCopyWithImpl<$Res> implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._self, this._then);

  final Rating _self;
  final $Res Function(Rating) _then;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rate = null,
    Object? count = null,
  }) {
    return _then(_self.copyWith(
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Rating implements Rating {
  const _Rating({required this.rate, required this.count});
  factory _Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  @override
  final double rate;
  @override
  final int count;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RatingCopyWith<_Rating> get copyWith =>
      __$RatingCopyWithImpl<_Rating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RatingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Rating &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rate, count);

  @override
  String toString() {
    return 'Rating(rate: $rate, count: $count)';
  }
}

/// @nodoc
abstract mixin class _$RatingCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$RatingCopyWith(_Rating value, $Res Function(_Rating) _then) =
      __$RatingCopyWithImpl;
  @override
  @useResult
  $Res call({double rate, int count});
}

/// @nodoc
class __$RatingCopyWithImpl<$Res> implements _$RatingCopyWith<$Res> {
  __$RatingCopyWithImpl(this._self, this._then);

  final _Rating _self;
  final $Res Function(_Rating) _then;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rate = null,
    Object? count = null,
  }) {
    return _then(_Rating(
      rate: null == rate
          ? _self.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
