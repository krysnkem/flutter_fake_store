import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_event.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';
import 'package:flutter_fake_store/presentation/widgets/products/failed_to_load_more.dart';
import 'package:flutter_fake_store/presentation/widgets/products/loading_products.dart';
import 'package:flutter_fake_store/presentation/widgets/products/no_products_found.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_fake_store/presentation/widgets/products/product_list_item.dart';
import 'package:flutter_fake_store/presentation/widgets/products/products_error_display.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageSpacing(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Head Section
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${context.welcome},',
                        style: AppTextStyles.urbanist24600TextBlack,
                      ),
                      Builder(
                        builder: (context) {
                          final username = context.select<AuthBloc, String?>(
                              (authbloc) => authbloc.state
                                      is AuthAuthenticatedState
                                  ? (authbloc.state as AuthAuthenticatedState)
                                      .username
                                  : null);
                          return Text(
                            username ?? 'username',
                            style: AppTextStyles.urbanist24600TextBlack,
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  const LogoutIconButton(),
                ],
              ),

              SizedBox(
                height: context.height(32),
              ),
              Text(
                context.fakeStore,
                style: AppTextStyles.urbanist28600TextBlack,
              ),
              SizedBox(
                height: context.height(22),
              ),

              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  final wishlistProductIds = <int>[];
                  final wishlistBloc = context.watch<WishlistBloc>();
                  final wishlistState = wishlistBloc.state;
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

                  switch (state) {
                    case ProductsInitial():
                    case ProductsLoadingAllProducts():
                      return const LoadingProducts();
                    case ProductsLoaded(products: final prods):
                      if (prods.isEmpty) {
                        return const NoProductsFound();
                      }
                      return ProductListSection(
                        products: prods,
                        onRefresh: () async => context.read<ProductsBloc>().add(
                              const GetAllProducts(),
                            ),
                        onTap: (product) => context.push(
                          AppRoutes.getProduct(
                            product.id.toString(),
                          ),
                        ),
                        wishListProductIds: wishlistProductIds,
                        onAddToWishList: onToggleWishlist,
                      );
                    case ProductsLoadingMoreProducts(
                        products: final prods,
                      ):
                      return ProductListSection(
                        products: prods,
                        isLoadingMore: true,
                        onRefresh: () async => context.read<ProductsBloc>().add(
                              const GetAllProducts(),
                            ),
                        onTap: (product) => context.push(
                          AppRoutes.getProduct(
                            product.id.toString(),
                          ),
                        ),
                        wishListProductIds: wishlistProductIds,
                        onAddToWishList: onToggleWishlist,
                      );
                    case MoreProductsError(
                        products: final prods,
                        message: final msg
                      ):
                      // Display loaded products and an error for the "load more" action
                      return Column(
                        children: [
                          Expanded(
                            child: ProductListSection(
                              products: prods,
                              onRefresh: () async =>
                                  context.read<ProductsBloc>().add(
                                        const GetAllProducts(),
                                      ),
                              onTap: (product) => context.push(
                                AppRoutes.getProduct(
                                  product.id.toString(),
                                ),
                              ),
                              wishListProductIds: wishlistProductIds,
                              onAddToWishList: onToggleWishlist,
                            ),
                          ),
                          FailedToLoadMore(msg: msg),
                        ],
                      );
                    case ProductsError(message: final msg):
                      return ProductsErrorDisplay(message: 'Error: $msg');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListSection extends StatefulWidget {
  const ProductListSection({
    super.key,
    required this.products,
    this.isLoadingMore = false,
    this.onRefresh,
    this.onTap,
    this.onAddToWishList,
    this.wishListProductIds = const [],
  });

  final List<Product> products;
  final bool isLoadingMore;
  final Future Function()? onRefresh;
  final void Function(Product product)? onTap;
  final void Function(Product product)? onAddToWishList;
  final List<int> wishListProductIds;

  @override
  State<ProductListSection> createState() => _ProductListSectionState();
}

class _ProductListSectionState extends State<ProductListSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_setupScrollLoadLogic);
  }

  void _setupScrollLoadLogic() {
    if (_scrollController.position.pixels != 0 &&
        _scrollController.position.atEdge) {
      context.read<ProductsBloc>().add(
            const GetMoreProducts(),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_setupScrollLoadLogic);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: widget.onRefresh ?? () async {},
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: widget.products.length + (widget.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= widget.products.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final product = widget.products[index];
            var imageUrl = product.image;
            final title = product.title;
            final category = product.category;
            final rating = product.rating.rate.toStringAsFixed(2);
            var price = product.price.toStringAsFixed(2);
            final isFavorite = widget.wishListProductIds.contains(product.id);
            return InkWell(
              onTap: () => widget.onTap?.call(product),
              child: ProductListItem(
                key: ValueKey(product.id + index),
                imageUrl: imageUrl,
                title: title,
                category: category,
                rating: rating,
                price: price,
                isFavorite: isFavorite,
                onAddToWishList: () => widget.onAddToWishList?.call(product),
              ),
            );
          },
        ),
      ),
    );
  }
}
