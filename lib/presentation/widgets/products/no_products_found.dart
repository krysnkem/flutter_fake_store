import 'package:flutter/material.dart';

class NoProductsFound extends StatelessWidget {
  const NoProductsFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text('No products found.'),
      ),
    );
  }
}
