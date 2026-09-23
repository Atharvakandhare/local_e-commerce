import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart_item.dart';
import '../../services/hive_service.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  Future<void> _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    final items = HiveService.getCart();

    emit(
      CartLoaded(
        List.unmodifiable(items),
      ),
    );
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = _currentItems();

    final index = currentItems.indexWhere(
      (item) => item.productId == event.product.id,
    );

    if (index >= 0) {
      final updatedItem = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + 1,
      );

      currentItems[index] = updatedItem;
    } else {
      currentItems.add(
        CartItem(
          productId: event.product.id,
          name: event.product.name,
          price: event.product.price,
          image: event.product.image,
          quantity: 1,
        ),
      );
    }

    await _saveAndEmit(
      currentItems,
      emit,
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = _currentItems();

    currentItems.removeWhere(
      (item) => item.productId == event.productId,
    );

    await _saveAndEmit(
      currentItems,
      emit,
    );
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = _currentItems();

    final index = currentItems.indexWhere(
      (item) => item.productId == event.productId,
    );

    if (index == -1) return;

    currentItems[index] = currentItems[index].copyWith(
      quantity: currentItems[index].quantity + 1,
    );

    await _saveAndEmit(
      currentItems,
      emit,
    );
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    final currentItems = _currentItems();

    final index = currentItems.indexWhere(
      (item) => item.productId == event.productId,
    );

    if (index == -1) return;

    final currentItem = currentItems[index];

    if (currentItem.quantity > 1) {
      currentItems[index] = currentItem.copyWith(
        quantity: currentItem.quantity - 1,
      );
    } else {
      currentItems.removeAt(index);
    }

    await _saveAndEmit(
      currentItems,
      emit,
    );
  }

  List<CartItem> _currentItems() {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;

      return List<CartItem>.from(
        currentState.items,
      );
    }

    return [];
  }

  Future<void> _saveAndEmit(
    List<CartItem> items,
    Emitter<CartState> emit,
  ) async {
    await HiveService.saveCart(items);

    emit(
      CartLoaded(
        List.unmodifiable(items),
      ),
    );
  }
}