import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/widgets/custom_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              PNGS.splashBackground,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: PageSpacing(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.height(250),
                    ),
                    Image.asset(PNGS.branding),
                    SizedBox(
                      height: context.height(18),
                    ),
                    const Text(
                      'Fake Store',
                      style: AppTextStyles.urbanist28600TextBlack,
                    ),
                    SizedBox(
                      height: context.height(40),
                    ),
                    CustomButton(
                      text: context.login,
                      isLoading: false,
                      isExpanded: true,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
