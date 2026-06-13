import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/order_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/order_status_badge.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return const EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'No orders yet',
            message: 'Your past orders will appear here once you place one.',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: orderController.orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return Card(
              child: ListTile(
                onTap: () => Get.toNamed(AppRoutes.orderDetails, arguments: order),
                title: Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${dateFormat.format(order.createdAt)} • ${order.itemCount} item(s)'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OrderStatusBadge(status: order.status),
                    const SizedBox(height: 4),
                    Text('\$${order.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
