import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var imageUrl = PNGS.splashBackground;
                    const title = '“Awaken, My Love!”';
                    const category = 'Childish Gambino';
                    const rating = '4.25';
                    var price = '12.99';
                    const isFavorite = true;
                    return ProductListItem(
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
