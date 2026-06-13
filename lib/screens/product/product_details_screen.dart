import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/wishlist_controller.dart';
import '../../models/product.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../../widgets/quantity_selector.dart';
import '../../widgets/rating_stars.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;
    final cart = Get.find<CartController>();
    final wishlist = Get.find<WishlistController>();
    final productController = Get.find<ProductController>();
    final hasDiscount = product.discountPrice != null;
    final related = productController.relatedProducts(product);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.textDark,
            pinned: true,
            expandedHeight: 320,
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                      wishlist.isWishlisted(product.id) ? Icons.favorite : Icons.favorite_border,
                      color: wishlist.isWishlisted(product.id) ? Colors.red : null,
                    ),
                    onPressed: () => wishlist.toggleWishlist(product.id),
                  )),
              IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    onPageChanged: (i) => setState(() => _imageIndex = i),
                    itemCount: product.imageUrls.length,
                    itemBuilder: (context, index) => Image.network(product.imageUrls[index], fit: BoxFit.cover),
                  ),
                  if (product.imageUrls.length > 1)
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          product.imageUrls.length,
                          (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == _imageIndex ? AppColors.primary : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingStars(rating: product.rating, showValue: true),
                      const SizedBox(width: 8),
                      Text('(${product.reviewCount} reviews)', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '\$${product.effectivePrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 10),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.isInStock ? '${product.stock} items in stock' : 'Out of stock',
                    style: TextStyle(
                      color: product.isInStock ? AppColors.secondary : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(product.description, style: TextStyle(color: Colors.grey[700], height: 1.5)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      QuantitySelector(
                        quantity: _quantity,
                        onIncrement: () => setState(() => _quantity++),
                        onDecrement: () => setState(() {
                          if (_quantity > 1) _quantity--;
                        }),
                      ),
                    ],
                  ),
                  if (related.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text('Related Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: related.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) => SizedBox(width: 160, child: ProductCard(product: related[index])),
                      ),
                    ),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: product.isInStock ? () => cart.addToCart(product, quantity: _quantity) : null,
                  child: const Text('Add to Cart', style: TextStyle(color: AppColors.primary)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: product.isInStock
                      ? () {
                          cart.addToCart(product, quantity: _quantity);
                          Get.toNamed(AppRoutes.checkout);
                        }
                      : null,
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
