import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_event.dart';
import 'package:flutter_fake_store/presentation/blocs/wishlist/wishlist_state.dart';
import 'package:flutter_fake_store/presentation/widgets/expandable_text.dart';
import 'package:flutter_fake_store/presentation/widgets/favourites_icon_button.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = product?.image ?? PNGS.branding;
    final String title = product?.title ?? 'Product Title';
    final String subtitle = product?.category ?? 'Product Subtitle';
    final String description = product?.description ?? 'Product Subtitle';
    final String price = '\$${product?.price.toStringAsFixed(2) ?? '0.00'}';
    final int reviewCount = product?.rating.count ?? 100;
    final rating = product?.rating.rate.toStringAsFixed(2) ?? '0.00';

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
              wishlistBloc.add(WishlistProductRemoved(product.id));
            } else {
              wishlistBloc.add(WishlistProductAdded(product.id));
            }
          };

    return ProducDetail(
      imageUrl: imageUrl,
      title: title,
      subtitle: subtitle.toUpperCase(),
      description: description,
      rating: rating,
      reviewCount: reviewCount,
      price: price,
      isFavourite: wishlistProductIds.contains(product?.id),
      onToggleWishlist: () => onToggleWishlist?.call(product!),
    );
  }
}

class ProducDetail extends StatelessWidget {
  const ProducDetail({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.description,
    this.onToggleWishlist,
    required this.isFavourite,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final String rating;
  final int reviewCount;
  final String price;
  final String description;
  final bool isFavourite;
  final VoidCallback? onToggleWishlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (ModalRoute.of(context)?.canPop ?? false) {
                Navigator.pop(context);
              }
            },
          ),
          const Spacer(),
          FavouritesIconButton(
            isFavorite: isFavourite,
            inactiveColor: AppColors.textGrey80,
            onToggleWishlist: onToggleWishlist,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image Section (centered top)
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageUrl.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            imageUrl,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ),
          ),

          // Foreground Content
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product title and subtitle section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width(24),
                    vertical: 24,
                  ),
                  color: AppColors.pureWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.urbanist24600TextGrey75,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: AppTextStyles.urbanist14600TextGrey,
                      ),
                      const SizedBox(height: 8),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: ExpandableText(
                          text: description,
                          style: AppTextStyles.urbanist14600TextGrey,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: AppTextStyles.urbanist14600DarkCharcoal,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$reviewCount ${context.review}${reviewCount > 1 ? 's' : ''}',
                            style: AppTextStyles.urbanist14600TextGrey60,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //price and button section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width(24),
                    vertical: 24,
                  ),
                  color: AppColors.accentYellow,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.price,
                            style: AppTextStyles.urbanist12600TextGrey75,
                          ),
                          Text(
                            price,
                            style: AppTextStyles.lora20600TextGrey80,
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(context.addToCart),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
