import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    products.assignAll(MockData.products);
    final uniqueCategories = MockData.products.map((p) => p.category).toSet().toList();
    categories.assignAll(['All', ...uniqueCategories]);
  }

  void updateSearchQuery(String query) => searchQuery.value = query;

  List<Product> get searchResults {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return [];
    return products
        .where((p) =>
            p.name.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query) ||
            p.description.toLowerCase().contains(query))
        .toList();
  }

  Product? getById(String id) {
    for (final p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  List<Product> relatedProducts(Product product, {int limit = 4}) {
    return products
        .where((p) => p.category == product.category && p.id != product.id)
        .take(limit)
        .toList();
  }
}
