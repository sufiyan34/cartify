class Address {
  final String id;
  final String label; // e.g. "Home", "Work"
  final String fullAddress;
  final String city;
  final String postalCode;
  final String country;
  final bool isDefault;

  Address({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.city,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      label: json['label'] as String,
      fullAddress: json['fullAddress'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'fullAddress': fullAddress,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'isDefault': isDefault,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final List<Address> addresses;
  final List<String> wishlistProductIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.addresses = const [],
    this.wishlistProductIds = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      addresses: (json['addresses'] as List? ?? [])
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlistProductIds: List<String>.from(json['wishlistProductIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'addresses': addresses.map((e) => e.toJson()).toList(),
      'wishlistProductIds': wishlistProductIds,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    List<Address>? addresses,
    List<String>? wishlistProductIds,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      addresses: addresses ?? this.addresses,
      wishlistProductIds: wishlistProductIds ?? this.wishlistProductIds,
    );
  }
}
