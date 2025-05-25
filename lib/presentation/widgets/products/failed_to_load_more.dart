import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';

class FailedToLoadMore extends StatelessWidget {
  const FailedToLoadMore({
    super.key,
    required this.msg,
  });

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Failed to load more: $msg',
        style: AppTextStyles.urbanist14600TextBlack.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
