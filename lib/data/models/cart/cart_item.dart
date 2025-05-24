import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required int quantity,
    required Product product,
  }) = _CartItem;

  /// Creates a [CartItem] instance from a JSON object.
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
