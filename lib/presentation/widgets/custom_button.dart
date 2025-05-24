import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.isExpanded = true,
  });

  final String text;
  final bool isLoading;
  final bool isExpanded;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 22.5,
                  height: 22.5,
                  child: CircularProgressIndicator(
                    color: AppColors.lightBackground,
                    strokeWidth: 4.0,
                  ),
                ),
              )
            : Text(text),
      ),
    );
  }
}
