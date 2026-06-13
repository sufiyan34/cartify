import 'package:get/get.dart';
import '../models/product.dart';

class WishlistController extends GetxController {
  final RxSet<String> wishlistIds = <String>{}.obs;

  bool isWishlisted(String productId) => wishlistIds.contains(productId);

  void toggleWishlist(String productId) {
    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
    } else {
      wishlistIds.add(productId);
    }
  }

  List<Product> getWishlistProducts(List<Product> allProducts) {
    return allProducts.where((p) => wishlistIds.contains(p.id)).toList();
  }
}
