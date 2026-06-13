import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import 'auth_controller.dart';

class OrderController extends GetxController {
  final RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    orders.assignAll(MockData.mockOrders);
  }

  Order placeOrder({
    required List<CartItem> items,
    required double subtotal,
    required double tax,
    required double shippingFee,
    required double total,
    required String address,
    required String paymentMethod,
  }) {
    final order = Order(
      id: 'ORD${1000 + orders.length + 1}',
      userId: Get.find<AuthController>().currentUser.value?.id ?? 'guest',
      items: items.map((e) => CartItem(product: e.product, quantity: e.quantity)).toList(),
      subtotal: subtotal,
      tax: tax,
      shippingFee: shippingFee,
      total: total,
      shippingAddress: address,
      paymentMethod: paymentMethod,
      status: OrderStatus.placed,
      createdAt: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 5)),
    );
    orders.insert(0, order);
    return order;
  }
}
