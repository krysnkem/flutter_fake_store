import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_event.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_fake_store/presentation/widgets/products/product_list_item.dart';

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

              // const ProductListSection(),
              // const LoadingProducts(),

              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  switch (state) {
                    case ProductsInitial():
                    case ProductsLoadingAllProducts():
                      return const LoadingProducts();
                    case ProductsLoaded(products: final prods):
                      if (prods.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text('No products found.'),
                          ),
                        );
                      }
                      return ProductListSection(products: prods);
                    case ProductsLoadingMoreProducts(
                        products: final prods,
                      ):
                      // Display currently loaded products.
                      // Optionally, ProductListSection could be enhanced
                      // to show a loading indicator at the bottom.
                      return ProductListSection(
                        products: prods,
                        isLoadingMore: true,
                      );
                    case MoreProductsError(
                        products: final prods,
                        message: final msg
                      ):
                      // Display loaded products and an error for the "load more" action
                      return Column(
                        children: [
                          Expanded(child: ProductListSection(products: prods)),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Failed to load more: $msg',
                              style: AppTextStyles.urbanist14600TextBlack
                                  .copyWith(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
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

class ProductsErrorDisplay extends StatelessWidget {
  final String message;
  const ProductsErrorDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            message,
            style: AppTextStyles.urbanist16600PureBlack
                .copyWith(color: Colors.red), // Example style
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LoadingProducts extends StatelessWidget {
  const LoadingProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
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
  });

  final List<Product> products;
  final bool isLoadingMore;

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
      child: ListView.builder(
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
          const isFavorite = true;
          return ProductListItem(
            key: ValueKey(product.id + index),
            imageUrl: imageUrl,
            title: title,
            category: category,
            rating: rating,
            price: price,
            isFavorite: isFavorite,
          );
        },
      ),
    );
  }
}
