import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'package:flutter_fake_store/data/repositories/data_repository.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_state.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartBloc extends Bloc<CartEvent, CartState> {
  final DataRepository _dataRepository;

  CartBloc(this._dataRepository) : super(CartStateInitial()) {
    on<CartItemUpdated>(_onCartItemUpdated);
    on<GetCartItems>(_onGetCartItems);
    on<CarItemRemoved>(_onCarItemRemoved);
    on<ResetCartItems>(_onResetCart);
  }

  void _onCarItemRemoved(CarItemRemoved event, Emitter<CartState> emit) async {
    List<CartItem> cartItems = [];
    List<CartItem> oldCartItems = [];

    if (state is CartItemsLoaded) {
      cartItems = (List<CartItem>.from((state as CartItemsLoaded).items));
      oldCartItems = (List<CartItem>.from((state as CartItemsLoaded).items));
    }

    final existingCartItemIndex = cartItems.indexWhere(
      (item) => item.product.id == event.productID,
    );

    if (existingCartItemIndex >= 0) {
      cartItems.removeAt(existingCartItemIndex);
    }

    final totalPrice = _calulcateTotal(cartItems);
    emit(CartItemsLoaded(items: cartItems, totalPrice: totalPrice));

    try {
      final result = await _dataRepository.removeFromCart(
        event.productID,
      );
      if (result is Failure) {
        emit(
          CartItemsLoaded(
            items: oldCartItems,
            totalPrice: _calulcateTotal(oldCartItems),
          ),
        );
        log('Failed to delete Cart Item ${result.message}');
      }
    } catch (e, stackTrace) {
      emit(
        CartItemsLoaded(
          items: oldCartItems,
          totalPrice: _calulcateTotal(oldCartItems),
        ),
      );
      log('Error deleting Cart $e \n $stackTrace');
    }
  }

  void _onCartItemUpdated(
      CartItemUpdated event, Emitter<CartState> emit) async {
    List<CartItem> cartItems = [];
    List<CartItem> oldCartItems = [];

    if (event.cartItem.quantity <= 0) {
      return;
    }
    if (state is CartItemsLoaded) {
      cartItems = (List<CartItem>.from((state as CartItemsLoaded).items));
      oldCartItems = (List<CartItem>.from((state as CartItemsLoaded).items));
    }

    final existingCartItemIndex = cartItems.indexWhere(
      (item) => item.product.id == event.cartItem.product.id,
    );

    if (existingCartItemIndex >= 0) {
      cartItems[existingCartItemIndex] = event.cartItem;
    } else {
      cartItems = [...cartItems, event.cartItem];
    }

    final totalPrice = _calulcateTotal(cartItems);
    emit(CartItemsLoaded(items: cartItems, totalPrice: totalPrice));

    try {
      final result = await _dataRepository.addToCart(
        event.cartItem.product,
        quantity: event.cartItem.quantity,
      );
      if (result is Failure) {
        emit(
          CartItemsLoaded(
            items: oldCartItems,
            totalPrice: _calulcateTotal(oldCartItems),
          ),
        );
        log('Failed to udpate Cart ${result.message}');
      }
    } catch (e, stackTrace) {
      emit(
        CartItemsLoaded(
          items: oldCartItems,
          totalPrice: _calulcateTotal(oldCartItems),
        ),
      );
      log('Error udpating Cart $e \n $stackTrace');
    }
  }

  double _calulcateTotal(List<CartItem> cartItems) {
    return cartItems.fold<double>(
        0, (value, item) => value + (item.product.price * item.quantity));
  }

  FutureOr<void> _onGetCartItems(
      GetCartItems event, Emitter<CartState> emit) async {
    emit(LoadingCartItems());
    try {
      final result = await _dataRepository.getCartItems();
      if (result is Success<List<CartItem>>) {
        emit(
          CartItemsLoaded(
            items: result.data!,
            totalPrice: _calulcateTotal(result.data!),
          ),
        );
      } else if (result is Failure) {
        emit(CartItemsError((result as Failure).message));
        log('Failure getting Cart Items ${(result as Failure).message}');
      }
    } catch (e, stackTrace) {
      log('Error getting Cart Items $e \n $stackTrace');
      emit(CartItemsError(e.toString()));
    }
  }

  FutureOr<void> _onResetCart(ResetCartItems event, Emitter<CartState> emit) {
    emit(CartStateInitial());
    _dataRepository.clearCart();
  }
}
