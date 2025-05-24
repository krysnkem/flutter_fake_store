import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/cart/cart_list_item.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var imageUrl = PNGS.splashBackground;
    const title = '“Awaken, My Love!”';
    const category = 'Childish Gambino';
    const rating = '4.25';
    var price = '12.99';
    const isFavorite = true;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Head Section
            PageSpacing(
              child: Row(
                children: [
                  Text(
                    context.cart,
                    style: AppTextStyles.urbanist24600TextBlack,
                  ),
                  const Spacer(),
                  const LogoutIconButton(),
                ],
              ),
            ),

            //Body Section
            SizedBox(
              height: context.height(32),
            ),

            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CartListItem(
                    imageUrl: imageUrl,
                    title: title,
                    category: category,
                    rating: rating,
                    price: price,
                    isFavorite: isFavorite,
                  );
                },
                itemCount: 10,
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.width(24),
                vertical: 24,
              ),
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                border: Border(
                    top: BorderSide(
                  color: AppColors.cardGrey,
                  width: 1,
                )),
              ),
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
                      child: Text(context.checkout),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
