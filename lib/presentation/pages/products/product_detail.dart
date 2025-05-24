import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/favourites_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String imageUrl = PNGS.branding;
    const String title = 'Product Title';
    const String subtitle = 'Product Subtitle';
    const String price = '\$99.99';
    const String buttonText = 'Add to Cart';

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle favorite action
            },
          ),
          const Spacer(),
          const FavouritesIconButton(
            isFavorite: false,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.urbanist12600DarkCharcoal,
                          ),
                          SizedBox(height: 8),
                          Text(
                            subtitle,
                            style: AppTextStyles.urbanist14600DarkCharcoal,
                          ),
                          SizedBox(height: 24),
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
                              const Text(
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
                              child: const Text(buttonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
