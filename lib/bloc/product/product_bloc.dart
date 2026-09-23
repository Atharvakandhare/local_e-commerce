import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      emit(const ProductLoaded(products));
    } catch (e) {
      emit(
        ProductError(
          'Unable to load products',
        ),
      );
    }
  }
}