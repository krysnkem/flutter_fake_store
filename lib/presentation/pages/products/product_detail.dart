import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/presentation/utils/cart_interaction_utils.dart';
import 'package:flutter_fake_store/presentation/utils/wishlist_interaction_utils.dart';
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
    final int reviewCount = product?.rating.count ?? 0;
    final rating = product?.rating.rate.toStringAsFixed(2) ?? '0.00';

    final wishlistDetails = context.getWishlistInteractionDetails(product);

    final cartDetails =
        product == null ? null : context.getCartInteractionDetails(product!);
    return ProducDetail(
      imageUrl: imageUrl,
      title: title,
      subtitle: subtitle.toUpperCase(),
      description: description,
      rating: rating,
      reviewCount: reviewCount,
      price: price,
      isFavourite: wishlistDetails.isFavourite,
      onToggleWishlist: wishlistDetails.onToggleWishlist,
      isInCart: cartDetails?.isInCart ?? false,
      onAddToCart: () => cartDetails?.onAddToCart?.call(),
      onRemoveFromCart: () => cartDetails?.onRemoveFromCart?.call(),
    );
  }
}

class ProducDetail extends StatelessWidget {
  const ProducDetail(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.rating,
      required this.reviewCount,
      required this.price,
      required this.description,
      this.onToggleWishlist,
      required this.isFavourite,
      this.isInCart = true,
      this.onAddToCart,
      this.onRemoveFromCart});

  final String imageUrl;
  final String title;
  final String subtitle;
  final String rating;
  final int reviewCount;
  final String price;
  final String description;
  final bool isFavourite;
  final bool isInCart;
  final VoidCallback? onToggleWishlist;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemoveFromCart;
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
                        child: Builder(builder: (context) {
                          if (isInCart) {
                            return OutlinedButton(
                              onPressed: onRemoveFromCart,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pureWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(context.removeFromCart),
                            );
                          }
                          return ElevatedButton(
                            onPressed: onAddToCart,
                            child: Text(context.addToCart),
                          );
                        }),
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
