import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';
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
                  final wishlistProductIds = <int>{};
                  final wishlistBloc = context.watch<WishlistBloc>();
                  final wishlistState = wishlistBloc.state;
                  final prods = <Product>{};

                  final productsBloc = context.watch<ProductsBloc>();
                  final productsState = productsBloc.state;

                  if (wishlistState is WishlistLoading ||
                      productsState is ProductsLoadingAllProducts ||
                      productsState is ProductsInitial) {
                    return const LoadingProducts();
                  }
                  if (wishlistState is WishlistLoaded) {
                    wishlistProductIds.addAll(wishlistState.productIds);
                  } else if (wishlistState is WislistUpdateError) {
                    wishlistProductIds.addAll(wishlistState.productIds);
                  }

                  final onToggleWishlist = wishlistState is WishlistLoading
                      ? null
                      : (Product product) {
                          if (wishlistProductIds.contains(product.id)) {
                            wishlistBloc
                                .add(WishlistProductRemoved(product.id));
                          } else {
                            wishlistBloc.add(WishlistProductAdded(product.id));
                          }
                        };

                  switch (productsState) {
                    case ProductsLoaded(:final products):
                    case ProductsLoadingMoreProducts(:final products):
                    case MoreProductsError(:final products):
                      prods.addAll(
                        products.where(
                          (product) => wishlistProductIds.any(
                            (id) => id == (product.id),
                          ),
                        ),
                      );
                      break;
                    default:
                  }

                  if (prods.isEmpty) {
                    return const NoProductsFound();
                  }
                  return WishListSection(
                    products: prods.toList(),
                    onTap: (product) => context.push(
                      AppRoutes.getProduct(
                        product.id.toString(),
                      ),
                    ),
                    wishListProductIds: wishlistProductIds.toList(),
                    onAddToWishList: onToggleWishlist,
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
              onAddToCart: () => widget.onAddToCart?.call(product),
            ),
          );
        },
      ),
    );
  }
}
