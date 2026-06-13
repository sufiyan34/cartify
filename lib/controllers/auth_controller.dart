import 'package:get/get.dart';
import '../data/mock_data.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';

class AuthController extends GetxController {
  final Rx<User?> currentUser = Rx<User?>(null);

  bool get isLoggedIn => currentUser.value != null;

  /// Mock authentication - any non-empty credentials succeed.
  void login(String email, String password) {
    currentUser.value = MockData.mockUser.copyWith(email: email);
    Get.offAllNamed(AppRoutes.home);
    Get.snackbar('Welcome back!', 'Logged in as $email');
  }

  void signup(String name, String email, String password) {
    currentUser.value = User(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      addresses: MockData.mockUser.addresses,
    );
    Get.offAllNamed(AppRoutes.home);
    Get.snackbar('Account created', 'Welcome, $name!');
  }

  void logout() {
    currentUser.value = null;
    Get.find<CartController>().clearCart();
    Get.offAllNamed(AppRoutes.login);
  }
}
