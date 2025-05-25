import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';

class ProductsErrorDisplay extends StatelessWidget {
  final String message;
  final Future Function()? refresh;
  const ProductsErrorDisplay({super.key, required this.message, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh ?? () async {},
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.22,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: AppTextStyles.urbanist16600PureBlack
                      .copyWith(color: Colors.red), // Example style
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
