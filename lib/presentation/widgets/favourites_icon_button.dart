import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';

class FavouritesIconButton extends StatelessWidget {
  const FavouritesIconButton({
    super.key,
    required this.isFavorite,
    this.inactiveColor,
  });

  final bool isFavorite;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Handle favorite toggle
      },
      padding: EdgeInsets.zero,
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 20,
        color: isFavorite
            ? AppColors.accentRed
            : inactiveColor ?? AppColors.textGrey40,
      ),
    );
  }
}
