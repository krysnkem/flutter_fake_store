import 'package:flutter/material.dart';
import 'package:flutter_fake_store/presentation/pages/auth/login.dart';
import 'package:flutter_fake_store/presentation/pages/auth/splash.dart';
import 'package:flutter_fake_store/presentation/pages/cart/cart.dart';
import 'package:flutter_fake_store/presentation/pages/products/product_detail.dart';
import 'package:flutter_fake_store/presentation/pages/products/products.dart';
import 'package:flutter_fake_store/presentation/pages/wishlist/wishlist.dart';
import 'package:flutter_fake_store/presentation/widgets/navigation_bar_scaffold.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey = GlobalKey<NavigatorState>();
final _wishlistShellNavigatorKey = GlobalKey<NavigatorState>();
final _cartShellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: cart,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigationBarScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeShellNavigatorKey,
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const ProductsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _wishlistShellNavigatorKey,
            routes: [
              GoRoute(
                path: wishlist,
                builder: (context, state) => const WishlistPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartShellNavigatorKey,
            routes: [
              GoRoute(
                path: cart,
                builder: (context, state) => const CartPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: productDetail,
        builder: (context, state) => const ProductDetailPage(),
      ),
    ],
  );

  // Route getters
  static String get splash => '/';
  static String get login => '/login';
  static String get home => '/home';
  static String get wishlist => '/wishlist';
  static String get cart => '/cart';
  static String get productDetail => '/product/:id';
}
