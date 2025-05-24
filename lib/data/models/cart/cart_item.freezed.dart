// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItem {
  int get quantity;
  Product get product;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CartItemCopyWith<CartItem> get copyWith =>
      _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartItem &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quantity, product);

  @override
  String toString() {
    return 'CartItem(quantity: $quantity, product: $product)';
  }
}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) =
      _$CartItemCopyWithImpl;
  @useResult
  $Res call({int quantity, Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res> implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? product = null,
  }) {
    return _then(_self.copyWith(
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CartItem implements CartItem {
  const _CartItem({required this.quantity, required this.product});
  factory _CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  @override
  final int quantity;
  @override
  final Product product;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CartItemCopyWith<_CartItem> get copyWith =>
      __$CartItemCopyWithImpl<_CartItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CartItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CartItem &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quantity, product);

  @override
  String toString() {
    return 'CartItem(quantity: $quantity, product: $product)';
  }
}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) =
      __$CartItemCopyWithImpl;
  @override
  @useResult
  $Res call({int quantity, Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$CartItemCopyWithImpl<$Res> implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? quantity = null,
    Object? product = null,
  }) {
    return _then(_CartItem(
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_self.product, (value) {
      return _then(_self.copyWith(product: value));
    });
  }
}

// dart format on
