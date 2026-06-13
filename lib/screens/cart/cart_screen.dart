import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/nav_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/empty_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final nav = Get.find<NavController>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return EmptyState(
            icon: Icons.shopping_cart_outlined,
            title: 'Your cart is empty',
            message: "Looks like you haven't added anything to your cart yet.",
            actionLabel: 'Continue Shopping',
            onAction: () => nav.changeTab(0),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) => CartItemTile(item: cart.items[index]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    _summaryRow('Subtotal', cart.subtotal),
                    _summaryRow('Tax (5%)', cart.tax),
                    _summaryRow('Shipping', cart.shippingFee, isFree: cart.shippingFee == 0),
                    const Divider(),
                    _summaryRow('Total', cart.total, isBold: true),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(AppRoutes.checkout),
                      child: const Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _summaryRow(String label, double value, {bool isBold = false, bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 16 : 14)),
          Text(
            isFree ? 'FREE' : '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
              color: isFree ? AppColors.secondary : (isBold ? AppColors.primary : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
