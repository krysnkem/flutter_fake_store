import 'package:equatable/equatable.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartStateInitial extends CartState {}

final class LoadingCartItems extends CartState {}

final class CartItemsLoaded extends CartState {
  final List<CartItem> items;
  final double totalPrice;

  const CartItemsLoaded({required this.items, required this.totalPrice});

  @override
  List<Object> get props => [items, totalPrice];
}

final class CartItemsError extends CartState {
  final String message;

  const CartItemsError(this.message);

  @override
  List<Object> get props => [message];
}
