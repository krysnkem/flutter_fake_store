import 'package:flutter_fake_store/data/models/auth/login_response.dart';
import 'package:flutter_fake_store/data/models/auth/saved_user.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/data/models/result.dart';

abstract class DataRepository {
  // Authentication
  Future<Result<LoginResponse>> login({
    required String email,
    required String password,
    required String username,
  });

  Future<Result<void>> logout();

  Future<Result<(bool, SavedUser)>> isLoggedIn();
  // Products
  Future<Result<List<Product>>> getProducts();

  // Favorites
  Future<Result<List<int>>> getFavoriteProductIDs();

  Future<Result<void>> addToFavorites(int productId);

  Future<Result<void>> removeFromFavorites(int productId);

  Future<Result<void>> clearFavorites();

  // Cart
  Future<Result<List<CartItem>>> getCartItems();

  Future<Result<void>> addToCart(Product product, {int quantity = 1});

  Future<Result<void>> removeFromCart(int productId);

  Future<Result<void>> clearCart();
}
