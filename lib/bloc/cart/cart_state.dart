import 'package:equatable/equatable.dart';

import '../../models/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  double get total {
    return items.fold(
      0,
      (sum, item) => sum + item.total,
    );
  }

  int get itemCount {
    return items.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  @override
  List<Object?> get props => [items];
}