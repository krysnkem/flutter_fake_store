import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/favourites_icon_button.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.isFavorite,
    this.productId,
  });

  final String imageUrl;
  final String title;
  final String category;
  final String rating;
  final String price;
  final bool isFavorite;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Image
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 12, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: isNetworkImage
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.accentYellow,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline,
                              color: AppColors.accentRed,
                              size: 30,
                            ),
                          )
                        : Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
          ),

          // Column 2: Text
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.urbanist16600PureBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: AppTextStyles.urbanist12600PureBlack50,
                    maxLines: 2, // Try adjusting this as needed
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        rating,
                        style: AppTextStyles.urbanist12600DarkCharcoal,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '\$$price',
                    style: AppTextStyles.urbanist14600TextGrey75,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Column 3: Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FavouritesIconButton(isFavorite: isFavorite),
            ],
          ),
        ],
      ),
    );
  }
}
