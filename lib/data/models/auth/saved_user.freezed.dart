// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedUser {
  String get username;

  /// Create a copy of SavedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedUserCopyWith<SavedUser> get copyWith =>
      _$SavedUserCopyWithImpl<SavedUser>(this as SavedUser, _$identity);

  /// Serializes this SavedUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedUser &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  @override
  String toString() {
    return 'SavedUser(username: $username)';
  }
}

/// @nodoc
abstract mixin class $SavedUserCopyWith<$Res> {
  factory $SavedUserCopyWith(SavedUser value, $Res Function(SavedUser) _then) =
      _$SavedUserCopyWithImpl;
  @useResult
  $Res call({String username});
}

/// @nodoc
class _$SavedUserCopyWithImpl<$Res> implements $SavedUserCopyWith<$Res> {
  _$SavedUserCopyWithImpl(this._self, this._then);

  final SavedUser _self;
  final $Res Function(SavedUser) _then;

  /// Create a copy of SavedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_self.copyWith(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SavedUser implements SavedUser {
  const _SavedUser({required this.username});
  factory _SavedUser.fromJson(Map<String, dynamic> json) =>
      _$SavedUserFromJson(json);

  @override
  final String username;

  /// Create a copy of SavedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedUserCopyWith<_SavedUser> get copyWith =>
      __$SavedUserCopyWithImpl<_SavedUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SavedUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedUser &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username);

  @override
  String toString() {
    return 'SavedUser(username: $username)';
  }
}

/// @nodoc
abstract mixin class _$SavedUserCopyWith<$Res>
    implements $SavedUserCopyWith<$Res> {
  factory _$SavedUserCopyWith(
          _SavedUser value, $Res Function(_SavedUser) _then) =
      __$SavedUserCopyWithImpl;
  @override
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$SavedUserCopyWithImpl<$Res> implements _$SavedUserCopyWith<$Res> {
  __$SavedUserCopyWithImpl(this._self, this._then);

  final _SavedUser _self;
  final $Res Function(_SavedUser) _then;

  /// Create a copy of SavedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? username = null,
  }) {
    return _then(_SavedUser(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
