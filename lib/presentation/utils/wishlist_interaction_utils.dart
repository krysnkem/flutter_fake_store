import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';

/// Holds the details for wishlist interaction UI.
class WishlistInteractionDetails {
  final bool isFavourite;
  final VoidCallback? onToggleWishlist;

  WishlistInteractionDetails({
    required this.isFavourite,
    this.onToggleWishlist,
  });
}

extension WishlistInteractionExtensions on BuildContext {
  /// Provides details for interacting with the wishlist for a given product.
  ///
  /// This includes whether the product is a favourite and a callback to toggle
  /// its wishlist status.
  WishlistInteractionDetails getWishlistInteractionDetails(Product? product) {
    if (product == null) {
      return WishlistInteractionDetails(
        isFavourite: false,
        onToggleWishlist: null,
      );
    }

    final wishlistEventBloc = read<WishlistBloc>(); // For dispatching events
    final wishlistState = watch<WishlistBloc>().state; // For observing state

    bool isFavourite = false;
    if (wishlistState is WishlistLoaded) {
      isFavourite = wishlistState.productIds.contains(product.id);
    } else if (wishlistState is WislistUpdateError) {
      // Matches typo in provided context
      isFavourite = wishlistState.productIds.contains(product.id);
    }

    final VoidCallback? onToggleWishlistCallback =
        wishlistState is WishlistLoading
            ? null
            : () {
                if (isFavourite) {
                  wishlistEventBloc.add(WishlistProductRemoved(product.id));
                } else {
                  wishlistEventBloc.add(WishlistProductAdded(product.id));
                }
              };

    return WishlistInteractionDetails(
      isFavourite: isFavourite,
      onToggleWishlist: onToggleWishlistCallback,
    );
  }


}
