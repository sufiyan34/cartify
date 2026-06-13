import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Get.find<WishlistController>();
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Obx(() {
        final items = wishlist.getWishlistProducts(productController.products);
        if (items.isEmpty) {
          return const EmptyState(
            icon: Icons.favorite_border,
            title: 'Your wishlist is empty',
            message: 'Tap the heart icon on any product to save it here.',
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) => ProductCard(product: items[index]),
        );
      }),
    );
  }
}
