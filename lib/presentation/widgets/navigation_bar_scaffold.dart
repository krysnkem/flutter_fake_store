import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_event.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NavigationBarScaffold extends StatelessWidget {
  const NavigationBarScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('NavigationBarScaffold'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticatedState) {
          context.read<CartBloc>().add(const ResetCartItems());
          context.read<WishlistBloc>().add(const ResetWishlist());
          context.read<ProductsBloc>().add(const ResetProducts());

          final String currentLocation =
              GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
          if (currentLocation != AppRoutes.login &&
              currentLocation != AppRoutes.splash) {
            context.go(AppRoutes.splash);
          }
        }
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color:
                AppColors.pureWhite, // Background color of the navigation bar
            border: Border(
              top: BorderSide(
                color: AppColors.textGrey60, // Customize border color
                width: 0.5, // Thin border
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                label: 'Home',
                icon: SvgPicture.asset(SVGS.homeInactive),
                selectedIcon: SvgPicture.asset(SVGS.homeActive),
              ),
              NavigationDestination(
                label: 'Wishlist',
                icon: SvgPicture.asset(SVGS.wishListInactive),
                selectedIcon: SvgPicture.asset(SVGS.wishListActive),
              ),
              NavigationDestination(
                label: 'Cart',
                icon: SvgPicture.asset(SVGS.cartInactive),
                selectedIcon: SvgPicture.asset(SVGS.cartActive),
              ),
            ],
            onDestinationSelected: _goBranch,
          ),
        ),
      ),
    );
  }
}
