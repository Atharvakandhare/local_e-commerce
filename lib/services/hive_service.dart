import 'package:hive_flutter/hive_flutter.dart';

import '../models/cart_item.dart';

class HiveService {
  static const String cartBoxName = 'cartBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(cartBoxName);
  }

  static Box get cartBox => Hive.box(cartBoxName);

  static Future<void> saveCart(List<CartItem> items) async {
    final data = items.map((item) => item.toMap()).toList();

    await cartBox.put('items', data);
  }
  static List<CartItem> getCart() {
    final data = cartBox.get('items', defaultValue: []);

    if (data is! List) {
      return [];
    }

    return data
        .map(
          (item) => CartItem.fromMap(
            Map<dynamic, dynamic>.from(item),
          ),
        )
        .toList();
  }

  static Future<void> clearCart() async {
    await cartBox.delete('items');
  }
}