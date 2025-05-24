import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_rating.dart'; // Or the correct relative path

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  /// Creates a [Product] instance.
  ///
  /// [id]: The unique identifier for the product.
  /// [title]: The title of the product.
  /// [price]: The price of the product.
  /// [description]: A description of the product.
  /// [category]: The category the product belongs to.
  /// [image]: URL of the product image.
  /// [rating]: The rating information for the product.
  const factory Product({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required Rating rating,
  }) = _Product;

  /// Creates a [Product] instance from a JSON object.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
