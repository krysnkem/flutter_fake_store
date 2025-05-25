import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';

class NoProductsFound extends StatelessWidget {
  const NoProductsFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          'Nothing here yet....',
          style: AppTextStyles.urbanist28600TextBlack,
        ),
      ),
    );
  }
}
