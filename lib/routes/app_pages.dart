import 'package:get/get.dart';
import '../screens/auth/login_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/main_nav_screen.dart';
import '../screens/order/order_confirmation_screen.dart';
import '../screens/order/order_details_screen.dart';
import '../screens/order/order_history_screen.dart';
import '../screens/product/product_details_screen.dart';
import '../screens/product/product_list_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/wishlist/wishlist_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.home, page: () => const MainNavScreen()),
    GetPage(name: AppRoutes.products, page: () => const ProductListScreen()),
    GetPage(name: AppRoutes.productDetails, page: () => const ProductDetailsScreen()),
    GetPage(name: AppRoutes.cart, page: () => const CartScreen()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: AppRoutes.orderConfirmation, page: () => const OrderConfirmationScreen()),
    GetPage(name: AppRoutes.orderHistory, page: () => const OrderHistoryScreen()),
    GetPage(name: AppRoutes.orderDetails, page: () => const OrderDetailsScreen()),
    GetPage(name: AppRoutes.search, page: () => const SearchScreen()),
    GetPage(name: AppRoutes.wishlist, page: () => const WishlistScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
  ];
}
