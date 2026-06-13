import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

enum _SortOption { none, priceLowHigh, priceHighLow, rating }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late String category;
  _SortOption _sort = _SortOption.none;

  @override
  void initState() {
    super.initState();
    category = (Get.arguments as String?) ?? 'All';
  }

  List<Product> _applySort(List<Product> products) {
    final list = [...products];
    switch (_sort) {
      case _SortOption.priceLowHigh:
        list.sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
        break;
      case _SortOption.priceHighLow:
        list.sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
        break;
      case _SortOption.rating:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case _SortOption.none:
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        actions: [
          PopupMenuButton<_SortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (value) => setState(() => _sort = value),
            itemBuilder: (context) => const [
              PopupMenuItem(value: _SortOption.none, child: Text('Default')),
              PopupMenuItem(value: _SortOption.priceLowHigh, child: Text('Price: Low to High')),
              PopupMenuItem(value: _SortOption.priceHighLow, child: Text('Price: High to Low')),
              PopupMenuItem(value: _SortOption.rating, child: Text('Top Rated')),
            ],
          ),
        ],
      ),
      body: Obx(() {
        final filtered = category == 'All'
            ? productController.products
            : productController.products.where((p) => p.category == category).toList();
        final sorted = _applySort(filtered);

        if (sorted.isEmpty) {
          return const Center(child: Text('No products found in this category'));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sorted.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) => ProductCard(product: sorted[index]),
        );
      }),
    );
  }
}
