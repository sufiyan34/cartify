import 'package:get/get.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.05;
  double get shippingFee => items.isEmpty ? 0.0 : (subtotal >= 50 ? 0.0 : 5.99);
  double get total => subtotal + tax + shippingFee;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(Product product, {int quantity = 1}) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index].quantity += quantity;
      items.refresh();
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
    Get.snackbar(
      'Added to Cart',
      '${product.name} added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void removeFromCart(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void incrementQuantity(String productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      items[index].quantity++;
      items.refresh();
    }
  }

  void decrementQuantity(String productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index < 0) return;
    if (items[index].quantity > 1) {
      items[index].quantity--;
      items.refresh();
    } else {
      removeFromCart(productId);
    }
  }

  void clearCart() => items.clear();
}
