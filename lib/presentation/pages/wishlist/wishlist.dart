import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:flutter_fake_store/presentation/utils/cart_interaction_utils.dart';
import 'package:flutter_fake_store/presentation/utils/wishlist_input_utlis.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_fake_store/presentation/widgets/products/loading_products.dart';
import 'package:flutter_fake_store/presentation/widgets/products/no_products_found.dart';
import 'package:flutter_fake_store/presentation/widgets/wishlist/wishlist_item.dart';
import 'package:go_router/go_router.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageSpacing(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    context.wishList,
                    style: AppTextStyles.urbanist24600TextBlack,
                  ),
                  const Spacer(),
                  const LogoutIconButton(),
                ],
              ),
              //Body Section
              SizedBox(
                height: context.height(32),
              ),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  final wishlistScreenInput = context.getWishListScreenInput();
                  final wishListProducts = wishlistScreenInput.wishlist;
                  final wishlistProductIds =
                      wishlistScreenInput.wishListProductIDs;
                  if (wishlistScreenInput.isLoading) {
                    return const LoadingProducts();
                  }
                  if (wishListProducts.isEmpty) {
                    return const NoProductsFound();
                  }
                  return WishListSection(
                    products: wishListProducts.toList(),
                    onTap: (product) => context.push(
                      AppRoutes.getProduct(
                        product.id.toString(),
                      ),
                    ),
                    wishListProductIds: wishlistProductIds.toList(),
                    onAddToWishList: wishlistScreenInput.onToggleWishlist,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WishListSection extends StatefulWidget {
  const WishListSection({
    super.key,
    required this.products,
    this.onTap,
    this.onAddToWishList,
    this.wishListProductIds = const [],
    this.onAddToCart,
  });

  final List<Product> products;
  final void Function(Product product)? onTap;
  final void Function(Product product)? onAddToWishList;
  final void Function(Product product)? onAddToCart;
  final List<int> wishListProductIds;

  @override
  State<WishListSection> createState() => _WishListSectionState();
}

class _WishListSectionState extends State<WishListSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_setupScrollLoadLogic);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          var imageUrl = product.image;
          final title = product.title;
          final category = product.category;
          final rating = product.rating.rate.toStringAsFixed(2);
          var price = product.price.toStringAsFixed(2);
          final isFavorite = widget.wishListProductIds.contains(product.id);
          final cartInteractions = context.getCartInteractionDetails(product);
          final isInCart = cartInteractions.isInCart;
          return InkWell(
            onTap: () => widget.onTap?.call(product),
            child: WishListItem(
              key: ValueKey(product.id + index),
              imageUrl: imageUrl,
              title: title,
              category: category,
              rating: rating,
              price: price,
              isFavorite: isFavorite,
              onAddToWishList: () => widget.onAddToWishList?.call(product),
              onToggleCart: isInCart
                  ? cartInteractions.onRemoveFromCart
                  : cartInteractions.onAddToCart,
              isInCart: isInCart,
            ),
          );
        },
      ),
    );
  }
}
