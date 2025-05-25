import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'package:flutter_fake_store/data/repositories/data_repository.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';
import 'package:injectable/injectable.dart';

@singleton
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(this._dataRepository) : super(WishlistInitial()) {
    on<GetWishlist>(_getWishlist);
    on<WishlistProductAdded>(_wishlistProductAdded);
    on<WishlistProductRemoved>(_wishlistProductRemoved);
    on<ResetWishlist>(_resetWishlist);
  }

  final DataRepository _dataRepository;

  FutureOr<void> _getWishlist(
      GetWishlist event, Emitter<WishlistState> emit) async {
    log('get wishlist');
    emit(WishlistLoading());
    try {
      final result = await _dataRepository.getFavoriteProductIDs();
      if (result is Success) {
        final wishListProductIds = ((result as Success).data as List<int>);

        emit(WishlistLoaded(productIds: wishListProductIds.toSet()));
        log('Wish list loaded');
        log('Wish list data $wishListProductIds');
      } else if (result is Failure) {
        emit(WishlistError(message: (result as Failure).message));
        log('Wish list Failure ${(result as Failure).message}');
      }
    } catch (e, stacktrace) {
      emit(WishlistError(message: e.toString()));
      log('Wish list error ${e.toString()} $stacktrace');
    }
  }

  FutureOr<void> _wishlistProductAdded(
      WishlistProductAdded event, Emitter<WishlistState> emit) async {
    Set<int> originalIds = {};
    Set<int> updatedIds = {};

    switch (state) {
      case WishlistLoaded(:final productIds):
      case WislistUpdateError(:final productIds):
        if (productIds.contains(event.productId)) {
          return;
        }
        originalIds = Set<int>.from(productIds); // Create new copy
        updatedIds = Set<int>.from(productIds)..add(event.productId); // NEW Set
        break;
      case WishlistInitial():
        updatedIds.add(event.productId);
        break;
      default:
        return;
    }

    emit(WishlistLoaded(productIds: updatedIds));

    try {
      final result = await _dataRepository.addToFavorites(event.productId);
      if (result is Failure) {
        emit(WislistUpdateError(
          message: result.message,
          productIds: originalIds,
        ));
      }
    } catch (e) {
      emit(WislistUpdateError(
        message: 'Failed to add product to wishlist $e',
        productIds: originalIds,
      ));
    }
  }

  FutureOr<void> _wishlistProductRemoved(
      WishlistProductRemoved event, Emitter<WishlistState> emit) async {
    Set<int> updatedIds = {};
    Set<int> originalIds = {};

    switch (state) {
      case WishlistLoaded(:final productIds):
      case WislistUpdateError(:final productIds):
        originalIds = Set<int>.from(productIds); // Create new copy
        updatedIds = Set<int>.from(originalIds)..remove(event.productId);
        break;
      default:
    }
    emit(WishlistLoaded(productIds: updatedIds));
    try {
      final result = await _dataRepository.removeFromFavorites(event.productId);
      if (result is Failure) {
        emit(
          WislistUpdateError(
            message: result.message,
            productIds: originalIds,
          ),
        );
      }
    } catch (e) {
      emit(
        WislistUpdateError(
          message: 'Failed to remove product to wishlist $e',
          productIds: originalIds,
        ),
      );
    }
  }

  FutureOr<void> _resetWishlist(
      ResetWishlist event, Emitter<WishlistState> emit) {
    emit(
      WishlistInitial(),
    );
  }
}
