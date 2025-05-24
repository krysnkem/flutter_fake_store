import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_user.freezed.dart';
part 'saved_user.g.dart';

@freezed
abstract class SavedUser with _$SavedUser {
  const factory SavedUser({
    required String username,
  }) = _SavedUser;

  factory SavedUser.fromJson(Map<String, dynamic> json) =>
      _$SavedUserFromJson(json);
}
