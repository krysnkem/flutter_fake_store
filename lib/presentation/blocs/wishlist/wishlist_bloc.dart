import 'dart:async';

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
  }

  final DataRepository _dataRepository;

  FutureOr<void> _getWishlist(GetWishlist event, Emitter<WishlistState> emit) {
    emit(WishlistLoading());
    try {
      final result = _dataRepository.getFavoriteProductIDs();
      if (result is Success) {
        final wishListProductIds = ((result as Success).data as List<int>);

        emit(WishlistLoaded(productIds: wishListProductIds.toSet()));
      } else if (result is Failure) {
        emit(WishlistError(message: (result as Failure).message));
      }
    } catch (e) {
      emit(WishlistError(message: e.toString()));
    }
  }

  FutureOr<void> _wishlistProductAdded(
      WishlistProductAdded event, Emitter<WishlistState> emit) async {
    Set<int> ids = {};
    Set<int> originalIds = {};

    if (state is! WishlistLoaded || state is! WislistUpdateError) {
      return;
    }
    switch (state) {
      case WishlistLoaded(:final productIds):
      case WislistUpdateError(:final productIds):
        originalIds.addAll(productIds);
        ids.addAll(productIds..add(event.productId));
        break;
      default:
    }
    emit(WishlistLoaded(productIds: ids));
    try {
      final result = await _dataRepository.addToFavorites(event.productId);
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
          message: 'Failed to add product to wishlist $e',
          productIds: originalIds,
        ),
      );
    }
  }

  FutureOr<void> _wishlistProductRemoved(
      WishlistProductRemoved event, Emitter<WishlistState> emit) async {
    Set<int> ids = {};
    Set<int> originalIds = {};

    if (state is! WishlistLoaded || state is! WislistUpdateError) {
      return;
    }
    switch (state) {
      case WishlistLoaded(:final productIds):
      case WislistUpdateError(:final productIds):
        originalIds.addAll(productIds);
        ids.addAll(productIds..remove(event.productId));
        break;
      default:
    }
    emit(WishlistLoaded(productIds: ids));
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
}
