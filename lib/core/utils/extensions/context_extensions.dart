import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double height(double value) {
    return (value / 812) * MediaQuery.of(this).size.height;
  }

  double width(double value) {
    return (value / 375) * MediaQuery.of(this).size.width;
  }
}

extension ContextTextExtensions on BuildContext {
  String get fakeStore => 'Fake Store';
  String get login => 'Login';
  String get welcomeBack => 'Welcome back! Glad to see you, Again!';
  String get enterYourUsername => 'Enter your username';
  String get enterYourPassword => 'Enter your password';
  String get welcome => 'Welcome';
  String get username => 'Username';
  String get password => 'Password';
  String get review => 'Review';
  String get price => 'Price';
  String get addToCart => 'Add to cart';
  String get removeFromCart => 'Remove from cart';
  String get addToWishlist => 'Add to cart';
  String get cart => 'Cart';
  String get logOut => 'Log out';
  String get cartTotal => 'Cart Total';
  String get checkout => 'Checkout';
  String get wishList => 'Wishlist';
  String get loginSuccess => 'Login successful!';
  String get loginError => 'Login failed. Please try again.';
  String get logoutSuccess => 'Logout successful!';
  String get logoutError => 'Logout failed. Please try again.';
  String get noItemsInCart => 'No items in cart';
  String get noItemsInWishlist => 'No items in wishlist';
}
