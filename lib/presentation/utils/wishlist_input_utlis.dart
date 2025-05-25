import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';

class WishlistInputInteractions {
  final Set<Product> wishlist;
  final Set<int> wishListProductIDs;
  final ValueChanged<Product>? onToggleWishlist;
  final bool isLoading;

  WishlistInputInteractions({
    required this.wishlist,
    required this.wishListProductIDs,
    required this.onToggleWishlist,
    required this.isLoading,
  });
}

extension WishlistInputUtlis on BuildContext {
  WishlistInputInteractions getWishListScreenInput() {
    final wishlistProductIds = <int>{};
    final wishlistBloc = watch<WishlistBloc>();
    final wishlistState = wishlistBloc.state;
    final wishListProducts = <Product>{};

    final productsBloc = watch<ProductsBloc>();
    final productsState = productsBloc.state;

    bool isLoading = false;

    if (wishlistState is WishlistLoading ||
        productsState is ProductsLoadingAllProducts ||
        productsState is ProductsInitial) {
      isLoading = true;
    }
    if (wishlistState is WishlistLoaded) {
      wishlistProductIds.addAll(wishlistState.productIds);
    } else if (wishlistState is WislistUpdateError) {
      wishlistProductIds.addAll(wishlistState.productIds);
    }

    final onToggleWishlist = wishlistState is WishlistLoading
        ? null
        : (Product product) {
            if (wishlistProductIds.contains(product.id)) {
              wishlistBloc.add(WishlistProductRemoved(product.id));
            } else {
              wishlistBloc.add(WishlistProductAdded(product.id));
            }
          };
    
    switch (productsState) {
      case ProductsLoaded(:final products):
      case ProductsLoadingMoreProducts(:final products):
      case MoreProductsError(:final products):
        wishListProducts.addAll(
          products.where(
            (product) => wishlistProductIds.any(
              (id) => id == (product.id),
            ),
          ),
        );
        break;
      default:
    }
    return WishlistInputInteractions(
      isLoading: isLoading,
      wishlist: wishListProducts,
      wishListProductIDs: wishlistProductIds,
      onToggleWishlist: onToggleWishlist,
    );
  }
}
