import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';

class PageSpacing extends StatelessWidget {
  const PageSpacing({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(24),
      ),
      child: child,
    );
  }
}
