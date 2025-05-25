import 'package:flutter/material.dart';
import 'package:flutter_fake_store/presentation/widgets/reusable_dialog.dart';

class Dialogs {
  Dialogs._();

  // Static helper methods for common use cases
  static Future<bool> showLogout(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const ReusableDialog(
        title: 'Logout',
        message:
            'Are you sure you want to logout? You\'ll need to login again to access your account.',
        confirmText: 'Logout',
        cancelText: 'Stay',
        icon: Icons.logout,
        isDestructive: true,
      ),
    ).then((value) => value ?? false);
  }

  static Future<bool> showDeleteFromCart(BuildContext context,
      {String? productName}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ReusableDialog(
        title: 'Remove Item',
        message: productName != null
            ? 'Remove "$productName" from your cart?'
            : 'Remove this item from your cart?',
        confirmText: 'Remove',
        cancelText: 'Keep',
        icon: Icons.remove_shopping_cart,
        isDestructive: true,
      ),
    ).then((value) => value ?? false);
  }

  static Future<bool> showClearCart(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const ReusableDialog(
        title: 'Clear Cart',
        message:
            'This will remove all items from your cart. This action cannot be undone.',
        confirmText: 'Clear All',
        cancelText: 'Cancel',
        icon: Icons.delete_sweep,
        isDestructive: true,
      ),
    ).then((value) => value ?? false);
  }

  static Future<bool> showAddToCart(BuildContext context,
      {String? productName}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ReusableDialog(
        title: 'Add to Cart',
        message: productName != null
            ? 'Add "$productName" to your cart?'
            : 'Add this item to your cart?',
        confirmText: 'Add',
        cancelText: 'Cancel',
        icon: Icons.add_shopping_cart,
        isDestructive: false,
      ),
    ).then((value) => value ?? false);
  }

  static Future<bool?> showCustomDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    IconData? icon,
    Color? iconColor,
    bool isDestructive = false,
    Widget? customContent,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ReusableDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        icon: icon,
        iconColor: iconColor,
        isDestructive: isDestructive,
        customContent: customContent,
      ),
    );
  }
}
