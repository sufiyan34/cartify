import 'package:cartify/models/cart_item.dart';
import 'package:cartify/models/order.dart';
import 'package:cartify/models/product.dart';
import 'package:cartify/models/user.dart';

class MockData {
  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Wireless Bluetooth Headphones',
      description:
          'Premium over-ear wireless headphones with active noise cancellation, 30-hour battery life, and crystal-clear sound quality. Perfect for music, calls, and travel.',
      price: 89.99,
      discountPrice: 69.99,
      imageUrls: [
        'https://picsum.photos/seed/headphones1/600/600',
        'https://picsum.photos/seed/headphones2/600/600',
      ],
      category: 'Electronics',
      rating: 4.5,
      reviewCount: 230,
      stock: 15,
    ),
    Product(
      id: 'p2',
      name: 'Smart Fitness Watch',
      description:
          'Track your heart rate, sleep, steps, and workouts with this sleek smartwatch. Features a vibrant AMOLED display and 7-day battery life.',
      price: 199.99,
      imageUrls: [
        'https://picsum.photos/seed/smartwatch1/600/600',
        'https://picsum.photos/seed/smartwatch2/600/600',
      ],
      category: 'Electronics',
      rating: 4.7,
      reviewCount: 412,
      stock: 8,
    ),
    Product(
      id: 'p3',
      name: 'Portable Bluetooth Speaker',
      description:
          'Compact, waterproof speaker with rich bass and 12-hour playtime. Take your music anywhere with this rugged, splash-proof design.',
      price: 49.99,
      discountPrice: 39.99,
      imageUrls: ['https://picsum.photos/seed/speaker1/600/600'],
      category: 'Electronics',
      rating: 4.3,
      reviewCount: 156,
      stock: 22,
    ),
    Product(
      id: 'p4',
      name: "Men's Classic Denim Jacket",
      description:
          'A timeless denim jacket made from premium cotton, featuring a comfortable fit and durable stitching that gets better with age.',
      price: 79.99,
      imageUrls: [
        'https://picsum.photos/seed/jacket1/600/600',
        'https://picsum.photos/seed/jacket2/600/600',
      ],
      category: 'Fashion',
      rating: 4.4,
      reviewCount: 98,
      stock: 30,
    ),
    Product(
      id: 'p5',
      name: "Women's Floral Summer Dress",
      description:
          'Lightweight and breezy floral dress, perfect for warm days. Made from breathable fabric with a flattering A-line silhouette.',
      price: 45.99,
      discountPrice: 35.99,
      imageUrls: [
        'https://picsum.photos/seed/dress1/600/600',
        'https://picsum.photos/seed/dress2/600/600',
      ],
      category: 'Fashion',
      rating: 4.6,
      reviewCount: 187,
      stock: 18,
    ),
    Product(
      id: 'p6',
      name: 'Performance Running Shoes',
      description:
          'Engineered for comfort and speed, these running shoes feature responsive cushioning and a breathable mesh upper.',
      price: 120.00,
      imageUrls: [
        'https://picsum.photos/seed/runningshoes1/600/600',
        'https://picsum.photos/seed/runningshoes2/600/600',
      ],
      category: 'Footwear',
      rating: 4.8,
      reviewCount: 530,
      stock: 12,
    ),
    Product(
      id: 'p7',
      name: 'Leather Casual Sneakers',
      description:
          'Classic white leather sneakers that pair effortlessly with any outfit. Cushioned insole for all-day comfort.',
      price: 95.00,
      discountPrice: 75.00,
      imageUrls: ['https://picsum.photos/seed/sneakers1/600/600'],
      category: 'Footwear',
      rating: 4.2,
      reviewCount: 64,
      stock: 0,
    ),
    Product(
      id: 'p8',
      name: 'Classic Aviator Sunglasses',
      description:
          'UV-protected aviator sunglasses with a polished metal frame and gradient lenses for a timeless, stylish look.',
      price: 59.99,
      imageUrls: ['https://picsum.photos/seed/sunglasses1/600/600'],
      category: 'Accessories',
      rating: 4.1,
      reviewCount: 76,
      stock: 25,
    ),
    Product(
      id: 'p9',
      name: 'Genuine Leather Wallet',
      description:
          'Slim, handcrafted leather wallet with multiple card slots and a coin pocket. Available in rich brown leather.',
      price: 34.99,
      discountPrice: 24.99,
      imageUrls: ['https://picsum.photos/seed/wallet1/600/600'],
      category: 'Accessories',
      rating: 4.5,
      reviewCount: 142,
      stock: 40,
    ),
    Product(
      id: 'p10',
      name: 'Ceramic Coffee Mug Set (Set of 4)',
      description:
          'Beautifully glazed ceramic mugs, dishwasher and microwave safe. Perfect for your morning coffee or evening tea.',
      price: 24.99,
      imageUrls: ['https://picsum.photos/seed/mugset1/600/600'],
      category: 'Home',
      rating: 4.5,
      reviewCount: 88,
      stock: 35,
    ),
    Product(
      id: 'p11',
      name: 'Aromatherapy Essential Oil Diffuser',
      description:
          'Create a calming atmosphere with this ultrasonic diffuser featuring color-changing LED lights and whisper-quiet operation.',
      price: 39.99,
      discountPrice: 29.99,
      imageUrls: ['https://picsum.photos/seed/diffuser1/600/600'],
      category: 'Home',
      rating: 4.4,
      reviewCount: 203,
      stock: 16,
    ),
    Product(
      id: 'p12',
      name: 'Organic Hydrating Face Serum',
      description:
          'Lightweight serum packed with hyaluronic acid and vitamin C to brighten and hydrate your skin for a natural glow.',
      price: 28.50,
      imageUrls: ['https://picsum.photos/seed/serum1/600/600'],
      category: 'Beauty',
      rating: 4.6,
      reviewCount: 320,
      stock: 50,
    ),
    Product(
      id: 'p13',
      name: 'Matte Liquid Lipstick Set (6 Colors)',
      description:
          'Long-lasting, smudge-proof matte lipsticks in six gorgeous shades, formulated to keep your lips moisturized all day.',
      price: 19.99,
      imageUrls: ['https://picsum.photos/seed/lipstick1/600/600'],
      category: 'Beauty',
      rating: 4.3,
      reviewCount: 167,
      stock: 60,
    ),
    Product(
      id: 'p14',
      name: 'Non-Slip Yoga Mat',
      description:
          'Extra-thick, eco-friendly yoga mat with superior grip and cushioning. Includes a carrying strap for easy transport.',
      price: 32.00,
      discountPrice: 24.00,
      imageUrls: ['https://picsum.photos/seed/yogamat1/600/600'],
      category: 'Sports',
      rating: 4.7,
      reviewCount: 245,
      stock: 28,
    ),
  ];

  static final User mockUser = User(
    id: 'u1',
    name: 'Alex Morgan',
    email: 'alex.morgan@example.com',
    phone: '+1 555 123 4567',
    addresses: [
      Address(
        id: 'addr1',
        label: 'Home',
        fullAddress: '221B Baker Street, Apt 4',
        city: 'London',
        postalCode: 'NW1 6XE',
        country: 'United Kingdom',
        isDefault: true,
      ),
      Address(
        id: 'addr2',
        label: 'Work',
        fullAddress: '1 Innovation Way, Suite 200',
        city: 'London',
        postalCode: 'EC2A 4BX',
        country: 'United Kingdom',
      ),
    ],
  );

  /// Pre-populated order history for the mock user.
  static List<Order> get mockOrders {
    final now = DateTime.now();

    final order1Items = [
      CartItem(product: products[0], quantity: 1),
      CartItem(product: products[5], quantity: 1),
    ];
    final order1Subtotal =
        order1Items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final order1Tax = order1Subtotal * 0.05;

    final order2Items = [
      CartItem(product: products[3], quantity: 2),
    ];
    final order2Subtotal =
        order2Items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final order2Tax = order2Subtotal * 0.05;

    return [
      Order(
        id: 'ORD1002',
        userId: 'u1',
        items: order2Items,
        subtotal: order2Subtotal,
        tax: order2Tax,
        shippingFee: 0,
        total: order2Subtotal + order2Tax,
        shippingAddress: '221B Baker Street, Apt 4, London, NW1 6XE',
        paymentMethod: 'Credit / Debit Card',
        status: OrderStatus.shipped,
        createdAt: now.subtract(const Duration(days: 2)),
        estimatedDelivery: now.add(const Duration(days: 1)),
      ),
      Order(
        id: 'ORD1001',
        userId: 'u1',
        items: order1Items,
        subtotal: order1Subtotal,
        tax: order1Tax,
        shippingFee: 0,
        total: order1Subtotal + order1Tax,
        shippingAddress: '221B Baker Street, Apt 4, London, NW1 6XE',
        paymentMethod: 'Cash on Delivery',
        status: OrderStatus.delivered,
        createdAt: now.subtract(const Duration(days: 10)),
        estimatedDelivery: now.subtract(const Duration(days: 5)),
      ),
    ];
  }
}
