import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_fake_store/presentation/widgets/wishlist/wishlist_item.dart';

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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var imageUrl = PNGS.splashBackground;
                    const title = '“Awaken, My Love!”';
                    const category = 'Childish Gambino';
                    const rating = '4.25';
                    var price = '12.99';
                    const isFavorite = false;
                    return WishListItem(
                      imageUrl: imageUrl,
                      title: title,
                      category: category,
                      rating: rating,
                      price: price,
                      isFavorite: isFavorite,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
