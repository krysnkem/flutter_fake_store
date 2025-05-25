import 'package:equatable/equatable.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

final class GetCartItems extends CartEvent {
  const GetCartItems();
}
final class ResetCartItems extends CartEvent {
  const ResetCartItems();
}

final class CartItemUpdated extends CartEvent {
  final CartItem cartItem;

  const CartItemUpdated(this.cartItem);
  @override
  List<Object?> get props => [cartItem];
}

final class CarItemRemoved extends CartEvent {
  final int productID;

  const CarItemRemoved(this.productID);
  @override
  List<Object?> get props => [productID];
}
