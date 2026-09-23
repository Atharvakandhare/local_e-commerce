class CartItem {
  final int productId;
  final String name;
  final double price;
  final String image;
  final int quantity;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  double get total => price * quantity;

  CartItem copyWith({
    int? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<dynamic, dynamic> map) {
    return CartItem(
      productId: map['productId'] as int,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }
}