import 'dart:convert';

import 'package:flutter_fake_store/data/api/api_client.dart';
import 'package:flutter_fake_store/data/cache/cache_service.dart';
import 'package:flutter_fake_store/data/models/auth/login_response.dart';
import 'package:flutter_fake_store/data/models/auth/saved_user.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'package:flutter_fake_store/data/repositories/data_repository.dart';
import 'package:flutter_fake_store/data/repositories/safe_call.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer';

@LazySingleton(as: DataRepository)
class DataRepositoryImpl with SafeCall implements DataRepository {
  final ApiClient _apiClient;
  final CacheService _cacheService;

  DataRepositoryImpl(this._apiClient, this._cacheService);

  static const String _cartKey = 'cart';
  static const String _favoritesKey = 'favorites';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';

  @override
  Future<Result<void>> addToCart(Product product, {int quantity = 1}) async {
    try {
      final result = await getCartItems();
      if (result is Failure) {
        return result;
      }
      final items = (result as Success<List<CartItem>>).data;
      List<CartItem> cartItems = items ?? [];
      // Check if product already exists in cart
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (existingItemIndex != -1) {
        // Update existing item quantity
        final existingItem = cartItems[existingItemIndex];
        final updatedItem = existingItem.copyWith(
          quantity: quantity,
        );
        cartItems[existingItemIndex] = updatedItem;
      } else {
        // Add new item to cart
        final newCartItem = CartItem(
          quantity: quantity,
          product: product,
        );
        cartItems.add(newCartItem);
      }

      // Save updated cart
      final cartJsons = cartItems.map((item) => item.toJson()).toList();
      await _cacheService.write(_cartKey, jsonEncode(cartJsons));

      return Success();
    } catch (e, stackTrace) {
      log('Failed to add to cart: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to add to cart: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> addToFavorites(int product) async {
    try {
      final result = await getFavoriteProductIDs();
      if (result is Failure) {
        return result;
      }
      final items = (result as Success<List<int>>).data;
      List<int> productIDs = items ?? [];
      // Check if product already exists in favorites
      final existingItemIndex = productIDs.indexWhere(
        (item) => item == product,
      );
      if (existingItemIndex == -1) {
        // Add new item to cart
        productIDs.add(product);
      }
      // Save updated cart
      await _cacheService.write(_favoritesKey, jsonEncode(productIDs));

      return Success();
    } catch (e, stackTrace) {
      log('Failed to add to favourites: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to add to favourites: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> clearCart() async {
    try {
      await _cacheService.delete(_cartKey);
      return Success();
    } catch (e, stackTrace) {
      log('Failed to clear cart: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to clear cart: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> clearFavorites() async {
    try {
      await _cacheService.delete(_favoritesKey);
      return Success();
    } catch (e, stackTrace) {
      log('Failed to clear favourites: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to clear favourites: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<CartItem>>> getCartItems() async {
    try {
      final cartData = await _cacheService.read(_cartKey);

      List<CartItem> cartItems = [];

      if (cartData != null) {
        final cartJsons = jsonDecode(cartData) as List<dynamic>;
        cartItems = cartJsons
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return Success(data: cartItems);
    } catch (e, stackTrace) {
      log('Failed to get cart items: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to get cart items: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<int>>> getFavoriteProductIDs() async {
    try {
      final favourites = await _cacheService.read(_favoritesKey);

      List<int> products = [];
      if (favourites != null) {
        final productJson = jsonDecode(favourites);
        List<int> productIds = List<int>.from(productJson);

        products.addAll(productIds);
      }
      return Success(data: products);
    } catch (e, stackTrace) {
      log('Failed to get favourites: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to get favourites: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<Product>>> getProducts() => safeApiCall(
      apiCall: () => _apiClient.getProducts(),
      fromJson: (data) => (data as List<dynamic>)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList());

  @override
  Future<Result<LoginResponse>> login({
    required String email,
    required String password,
    required String username,
  }) =>
      safeApiCall(
        apiCall: () => _apiClient.login(
          email: email,
          password: password,
          username: username,
        ),
        fromJson: (data) =>
            LoginResponse.fromJson(data as Map<String, dynamic>),
      ).then((result) {
        if (result is Success<LoginResponse>) {
          // Save login status
          _cacheService.write(_isLoggedInKey, jsonEncode(true));
          _cacheService.write(_usernameKey, username);
        }
        return result;
      });

  @override
  Future<Result<void>> logout() async {
    try {
      await Future.wait([
        _cacheService.delete(_cartKey),
        _cacheService.delete(_favoritesKey),
        _cacheService.delete(_isLoggedInKey),
        _cacheService.delete(_usernameKey),
      ]);
      return Success();
    } catch (e, stackTrace) {
      log('Failed to logout: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> removeFromCart(int productId) async {
    try {
      final result = await getCartItems();
      if (result is Failure) {
        return result;
      }
      final items = (result as Success<List<CartItem>>).data;
      List<CartItem> cartItems = items ?? [];
      // Check if product already exists in cart
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.product.id == productId,
      );
      if (existingItemIndex != -1) {
        // Remove item from cart
        cartItems.removeAt(existingItemIndex);
      } else {
        return Failure(message: 'Product not found in cart');
      }
      // Save updated cart
      final cartJsons = cartItems.map((item) => item.toJson()).toList();
      await _cacheService.write(_cartKey, jsonEncode(cartJsons));
      return Success();
    } catch (e, stackTrace) {
      log('Failed to remove from cart: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to remove from cart: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> removeFromFavorites(int productId) async {
    try {
      final result = await getFavoriteProductIDs();
      if (result is Failure) {
        return result;
      }
      final items = (result as Success<List<int>>).data;
      List<int> products = items ?? [];
      // Check if product already exists in cart
      final existingItemIndex = products.indexWhere(
        (item) => item == productId,
      );
      if (existingItemIndex != -1) {
        // Remove item from cart
        products.removeAt(existingItemIndex);
      }
      // Save updated cart
      await _cacheService.write(_favoritesKey, jsonEncode(products));
      return Success();
    } catch (e, stackTrace) {
      log('Failed to remove from favourites: $e', stackTrace: stackTrace);
      return Failure(
        message: 'Failed to remove from favourites: ${e.toString()}',
      );
    }
  }

  @override
  Future<Result<(bool, SavedUser)>> isLoggedIn() async {
    try {
      final isLoggedIn = await _cacheService.read(_isLoggedInKey);
      final username = await _cacheService.read(_usernameKey);
      return Success(
        data: (
          isLoggedIn != null,
          SavedUser(username: username ?? ''),
        ),
      );
    } catch (e, stackTrace) {
      log('Failed to check login status: $e', stackTrace: stackTrace);
      return Failure(message: 'Failed to check login status: ${e.toString()}');
    }
  }
}
