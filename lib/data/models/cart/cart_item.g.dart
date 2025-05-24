// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
      quantity: (json['quantity'] as num).toInt(),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
    };
