import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/dialog/dialogs.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/data/models/cart/cart_item.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_fake_store/presentation/blocs/cart/cart_state.dart';
import 'package:flutter_fake_store/presentation/widgets/cart/cart_list_item.dart';
import 'package:flutter_fake_store/presentation/widgets/logout_icon_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:flutter_fake_store/presentation/widgets/products/loading_products.dart';
import 'package:flutter_fake_store/presentation/widgets/products/no_products_found.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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

            const CartSection(),
          ],
        ),
      ),
    );
  }
}

class CartSection extends StatelessWidget {
  const CartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          CartList(),
          PriceAndCheckout(),
        ],
      ),
    );
  }
}

class PriceAndCheckout extends StatelessWidget {
  const PriceAndCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = [];
    String price = '0.00';
    bool enableButton = false;

    final cartBlocState = context.watch<CartBloc>().state;
    if (cartBlocState is CartItemsLoaded) {
      cartItems = cartBlocState.items;
      if (cartItems.isNotEmpty) {
        price = cartBlocState.totalPrice.toStringAsFixed(2);
        enableButton = true;
      }
    }

  return Container(
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
                '\$$price',
                style: AppTextStyles.lora20600TextGrey80,
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: !enableButton ? null : () {},
              child: Text(context.checkout),
            ),
          ),
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = [];

    final cartBloc = context.read<CartBloc>();
    final cartBlocState = context.watch<CartBloc>().state;
    if (cartBlocState is CartItemsLoaded) {
      cartItems = cartBlocState.items;
    }
    if (cartBlocState is LoadingCartItems) {
      return const LoadingProducts();
    }

    if (cartItems.isEmpty) {
      return const NoProductsFound();
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          var imageUrl = cartItem.product.image;
          if (imageUrl.isEmpty) imageUrl = PNGS.splashBackground;

          final title = cartItem.product.title;
          final category = cartItem.product.category;
          final rating = cartItem.product.rating.rate.toStringAsFixed(2);
          final price = cartItem.product.price.toStringAsFixed(2);
          final quantity = cartItem.quantity;
          return CartListItem(
            imageUrl: imageUrl,
            title: title,
            category: category,
            rating: rating,
            price: price,
            quantity: quantity,
            onDelete: () => Dialogs.showDeleteFromCart(context).then(
              (isTrue) => isTrue
                  ? cartBloc.add(CarItemRemoved(cartItem.product.id))
                  : null,
            ),
            onIncrease: () => cartBloc.add(
              CartItemUpdated(
                cartItem.copyWith(quantity: quantity + 1),
              ),
            ),
            onReduce: () => cartBloc.add(
              CartItemUpdated(
                cartItem.copyWith(
                  quantity:
                      // quantity > 1 ?

                      quantity - 1
                  // : 1
                  ,
                ),
              ),
            ),
          );
        },
        itemCount: cartItems.length,
      ),
    );
  }
}
