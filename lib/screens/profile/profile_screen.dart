import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        final user = auth.currentUser.value;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        user != null && user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user?.name ?? 'Guest User', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(user?.email ?? '', style: TextStyle(color: Colors.grey[600])),
                          if (user?.phone != null) Text(user!.phone!, style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _menuTile(Icons.receipt_long_outlined, 'My Orders', () => Get.toNamed(AppRoutes.orderHistory)),
            _menuTile(Icons.location_on_outlined, 'Addresses', () {
              final addresses = user?.addresses ?? [];
              Get.dialog(AlertDialog(
                title: const Text('Saved Addresses'),
                content: addresses.isEmpty
                    ? const Text('No saved addresses yet.')
                    : SizedBox(
                        width: double.maxFinite,
                        child: ListView(
                          shrinkWrap: true,
                          children: addresses
                              .map((a) => ListTile(
                                    title: Text(a.label),
                                    subtitle: Text('${a.fullAddress}, ${a.city}'),
                                  ))
                              .toList(),
                        ),
                      ),
                actions: [TextButton(onPressed: () => Get.back(), child: const Text('Close'))],
              ));
            }),
            _menuTile(Icons.settings_outlined, 'Settings', () => Get.snackbar('Settings', 'Settings screen coming soon')),
            _menuTile(Icons.help_outline, 'Help & Support', () => Get.snackbar('Help & Support', 'Support screen coming soon')),
            const SizedBox(height: 8),
            _menuTile(
              Icons.logout,
              'Logout',
              () {
                Get.dialog(AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        auth.logout();
                      },
                      child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ));
              },
              color: Colors.red,
            ),
          ],
        );
      }),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.textDark),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
