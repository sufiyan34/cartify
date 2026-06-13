import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _popularSearches = const ['Headphones', 'Shoes', 'Watch', 'Dress', 'Sunglasses', 'Lipstick'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: productController.updateSearchQuery,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Obx(() => productController.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    productController.updateSearchQuery('');
                  },
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        final query = productController.searchQuery.value;
        if (query.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Popular Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _popularSearches
                      .map((term) => ActionChip(
                            label: Text(term),
                            backgroundColor: AppColors.surface,
                            onPressed: () {
                              _controller.text = term;
                              productController.updateSearchQuery(term);
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        }

        final results = productController.searchResults;
        if (results.isEmpty) {
          return EmptyState(
            icon: Icons.search_off,
            title: 'No results found',
            message: 'No products match "$query". Try a different keyword.',
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: results.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) => ProductCard(product: results[index]),
        );
      }),
    );
  }
}
