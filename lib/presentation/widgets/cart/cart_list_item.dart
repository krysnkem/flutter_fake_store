import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.isFavorite,
    this.productId,
    this.onDelete,
  });

  final String imageUrl;
  final String title;
  final String category;
  final String rating;
  final String price;
  final bool isFavorite;
  final String? productId;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Material(
        color: Colors.transparent,
        child: Slidable(
          key: ValueKey(productId ?? title),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              CustomSlidableAction(
                onPressed: (context) {
                  // Remove the notification
                  showDeleteDialog(context);
                  // Show undo SnackBar
                },
                backgroundColor: AppColors.deleteRed,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.pureWhite,
                  size: 20, // Specify exact size you want
                ),
              ),
            ],
          ),
          child: PageSpacing(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Column 1: Image
                Column(
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
                                errorWidget: (context, url, error) =>
                                    const Icon(
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
                const SizedBox(
                  width: 16,
                ),
                // Column 2: Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.urbanist16600PureBlack,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _quantityButton(
                            icon: Icons.remove_circle_outline,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                            onTap: () {}, // Add your logic here
                          ),
                          _quantityDisplay('1'),
                          _quantityButton(
                            icon: Icons.add_circle_outline,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            onTap: () {}, // Add your logic here
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Column 3: Icon
                Text(
                  '\$$price',
                  style: AppTextStyles.urbanist14600PureBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Item'),
        content: const Text(
            'Are you sure you want to remove this item from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

// 1. Button decoration method
  BoxDecoration _quantityButtonDecoration(BorderRadius borderRadius) {
    return BoxDecoration(
      border: Border.all(color: AppColors.buttonOutlineGrey),
      borderRadius: borderRadius,
      color: Colors.white,
    );
  }

// 2. Complete button widget method
  Widget _quantityButton({
    required IconData icon,
    required BorderRadius borderRadius,
    required VoidCallback? onTap,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: 40,
        height: 40,
        decoration: _quantityButtonDecoration(borderRadius),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? AppColors.pureBlack,
        ),
      ),
    );
  }

// 3. Text display method
  Widget _quantityDisplay(String quantity) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.buttonOutlineGrey),
          bottom: BorderSide(color: AppColors.buttonOutlineGrey),
        ),
      ),
      child: Center(
        child: Text(
          quantity,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
