import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../bloc/product/product_bloc.dart';
//import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../widgets/product_cart.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onCartTap;

  const HomeScreen({
    super.key,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-Commerce Shop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = 0;

              if (state is CartLoaded) {
                count = state.itemCount;
              }

              return Stack(
                children: [
                  IconButton(
                    onPressed: onCartTap,
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: state.products.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return ProductCard(
                    product: product,
                    onAddToCart: () {
                      context.read<CartBloc>().add(
                            AddToCart(product),
                          );

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} added to cart',
                          ),
                          duration:
                              const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}