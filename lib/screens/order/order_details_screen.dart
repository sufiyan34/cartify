import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/order.dart';
import '../../theme/app_theme.dart';
import '../../widgets/order_status_badge.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  static const _statusSteps = [
    OrderStatus.placed,
    OrderStatus.processing,
    OrderStatus.shipped,
    OrderStatus.delivered,
  ];
  static const _statusLabels = ['Placed', 'Processing', 'Shipped', 'Delivered'];
  static const _statusIcons = [
    Icons.shopping_bag_outlined,
    Icons.inventory_2_outlined,
    Icons.local_shipping_outlined,
    Icons.home_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Order;
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final currentStep = _statusSteps.indexOf(order.status);

    return Scaffold(
      appBar: AppBar(title: Text('Order ${order.id}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFormat.format(order.createdAt), style: TextStyle(color: Colors.grey[600])),
              OrderStatusBadge(status: order.status),
            ],
          ),
          const SizedBox(height: 20),
          if (order.status != OrderStatus.cancelled) _statusTracker(currentStep),
          const SizedBox(height: 24),
          const Text('Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: order.items
                  .map((item) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(item.product.imageUrls.first, width: 48, height: 48, fit: BoxFit.cover),
                        ),
                        title: Text(item.product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('Qty: ${item.quantity}'),
                        trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(order.shippingAddress))),
          const SizedBox(height: 16),
          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(order.paymentMethod))),
          const SizedBox(height: 16),
          const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _row('Subtotal', order.subtotal),
                  _row('Tax', order.tax),
                  _row('Shipping', order.shippingFee, isFree: order.shippingFee == 0),
                  const Divider(),
                  _row('Total', order.total, isBold: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _statusTracker(int currentStep) {
    return Row(
      children: List.generate(_statusSteps.length, (index) {
        final isActive = index <= currentStep;
        final isLast = index == _statusSteps.length - 1;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (index != 0)
                    Expanded(child: Container(height: 2, color: index <= currentStep ? AppColors.primary : Colors.grey[300])),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? AppColors.primary : Colors.grey[300],
                    ),
                    child: Icon(_statusIcons[index], color: Colors.white, size: 16),
                  ),
                  if (!isLast)
                    Expanded(child: Container(height: 2, color: index < currentStep ? AppColors.primary : Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                _statusLabels[index],
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? AppColors.primary : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _row(String label, double value, {bool isBold = false, bool isFree = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            isFree ? 'FREE' : '\$${value.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
