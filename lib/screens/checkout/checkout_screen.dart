import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../models/user.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late List<Address> _addresses;
  String? _selectedAddressId;
  String _paymentMethod = 'Cash on Delivery';

  final _paymentOptions = const ['Cash on Delivery', 'Credit / Debit Card', 'Wallet'];

  @override
  void initState() {
    super.initState();
    final user = Get.find<AuthController>().currentUser.value;
    _addresses = List<Address>.from(user?.addresses ?? []);
    if (_addresses.isNotEmpty) {
      _selectedAddressId = _addresses.firstWhere((a) => a.isDefault, orElse: () => _addresses.first).id;
    }
  }

  void _addAddress() {
    final labelController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final postalController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: labelController, decoration: const InputDecoration(labelText: 'Label (e.g. Home, Work)')),
              const SizedBox(height: 8),
              TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Address')),
              const SizedBox(height: 8),
              TextField(controller: cityController, decoration: const InputDecoration(labelText: 'City')),
              const SizedBox(height: 8),
              TextField(controller: postalController, decoration: const InputDecoration(labelText: 'Postal Code')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (addressController.text.trim().isEmpty) return;
              final newAddress = Address(
                id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
                label: labelController.text.trim().isEmpty ? 'Other' : labelController.text.trim(),
                fullAddress: addressController.text.trim(),
                city: cityController.text.trim(),
                postalCode: postalController.text.trim(),
                country: 'United Kingdom',
              );
              setState(() {
                _addresses.add(newAddress);
                _selectedAddressId = newAddress.id;
              });
              Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    if (_selectedAddressId == null) {
      Get.snackbar('Address Required', 'Please select or add a delivery address');
      return;
    }
    final cart = Get.find<CartController>();
    final orderController = Get.find<OrderController>();
    final address = _addresses.firstWhere((a) => a.id == _selectedAddressId);

    final order = orderController.placeOrder(
      items: cart.items.toList(),
      subtotal: cart.subtotal,
      tax: cart.tax,
      shippingFee: cart.shippingFee,
      total: cart.total,
      address: '${address.fullAddress}, ${address.city}, ${address.postalCode}',
      paymentMethod: _paymentMethod,
    );

    cart.clearCart();
    Get.offNamed(AppRoutes.orderConfirmation, arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton.icon(onPressed: _addAddress, icon: const Icon(Icons.add, size: 18), label: const Text('Add New')),
              ],
            ),
            if (_addresses.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('No saved addresses. Add one to continue.'),
              ),
            ..._addresses.map((address) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RadioListTile<String>(
                    value: address.id,
                    groupValue: _selectedAddressId,
                    onChanged: (value) => setState(() => _selectedAddressId = value),
                    title: Text(address.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${address.fullAddress}, ${address.city}, ${address.postalCode}'),
                    activeColor: AppColors.primary,
                  ),
                )),
            const SizedBox(height: 16),
            const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ..._paymentOptions.map((option) => Card(
                  margin: const EdgeInsets.only(top: 8),
                  child: RadioListTile<String>(
                    value: option,
                    groupValue: _paymentMethod,
                    onChanged: (value) => setState(() => _paymentMethod = value!),
                    title: Text(option),
                    activeColor: AppColors.primary,
                  ),
                )),
            const SizedBox(height: 16),
            const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => Column(
                      children: [
                        ...cart.items.map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.product.name} x${item.quantity}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                                ],
                              ),
                            )),
                        const Divider(),
                        _row('Subtotal', cart.subtotal),
                        _row('Tax', cart.tax),
                        _row('Shipping', cart.shippingFee, isFree: cart.shippingFee == 0),
                        const Divider(),
                        _row('Total', cart.total, isBold: true),
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _placeOrder, child: const Text('Place Order')),
            const SizedBox(height: 24),
          ],
        ),
      ),
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
