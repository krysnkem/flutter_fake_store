import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
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
    initialLocation: splash,
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
        path: _productDetail,
        builder: (context, state) {
          Product? product;
          final data = state.pathParameters['id'];
          if (data != null) {
            final productId = int.parse(data);
            final productBlocState = context.read<ProductsBloc>().state;
            List<Product> products = [];
            if (productBlocState is ProductsLoaded) {
              products.addAll((productBlocState).products);
            } else if (productBlocState is ProductsLoadingMoreProducts) {
              products.addAll((productBlocState).products);
            } else if (productBlocState is MoreProductsError) {
              products.addAll((productBlocState).products);
            }
            try {
              product = products.firstWhere(
                (element) => element.id == productId,
              );
            } catch (e) {}
          }
          return ProductDetailPage(
            product: product,
          );
        },
      ),
    ],
  );

  // Route getters
  static String get splash => '/';
  static String get login => '/login';
  static String get home => '/home';
  static String get wishlist => '/wishlist';
  static String get cart => '/cart';
  static String get _productDetail => '/product/:id';
  static String getProduct(String id) => _productDetail.replaceAll(':id', id);
}
