import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_state.dart';

/// Holds the details for cart interaction UI.
class CartInteractionDetails {
  final bool isInCart;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemoveFromCart;

  CartInteractionDetails({
    required this.isInCart,
    this.onAddToCart,
    this.onRemoveFromCart,
  });
}

extension CartInteractionExtensions on BuildContext {
  /// Provides details for interacting with the cart for a given product.
  ///
  /// This includes whether the product is in the cart, and callbacks for
  /// adding to or removing from the cart.
  CartInteractionDetails getCartInteractionDetails(Product product) {
    final cartBloc = read<CartBloc>(); // For dispatching events
    final cartState = watch<CartBloc>().state; // For observing state

    bool isInCart = false;
    if (cartState is CartItemsLoaded) {
      isInCart = cartState.items.any((item) => item.product.id == product.id);
    }

    final bool isLoading = cartState is LoadingCartItems;

    final VoidCallback? onAddToCartCallback = isLoading
        ? null
        : () => cartBloc
            .add(CartItemUpdated(CartItem(quantity: 1, product: product)));

    final VoidCallback? onRemoveFromCartCallback =
        isLoading ? null : () => cartBloc.add(CarItemRemoved(product.id));

    return CartInteractionDetails(
      isInCart: isInCart,
      onAddToCart: onAddToCartCallback,
      onRemoveFromCart: onRemoveFromCartCallback,
    );
  }
}
