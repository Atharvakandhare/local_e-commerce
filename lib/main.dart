import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart/cart_state.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/cart/cart_event.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/product/product_event.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'services/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(const EcommerceCartApp());
}

class EcommerceCartApp extends StatelessWidget {
  const EcommerceCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc()
            ..add(
              LoadProducts(),
            ),
        ),
        BlocProvider(
          create: (_) => CartBloc()
            ..add(
              LoadCart(),
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Local Shop',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
          scaffoldBackgroundColor:
              const Color(0xFFF7F7F8),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() =>
      _MainNavigationState();
}

class _MainNavigationState
    extends State<MainNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(
            onCartTap: () {
              setState(() {
                currentIndex = 1;
              });
            },
          ),
          const CartScreen(),
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int count = 0;

          if (state is CartLoaded) {
            count = state.itemCount;
          }

          return NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Shop',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
                selectedIcon: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  child: const Icon(
                    Icons.shopping_cart,
                  ),
                ),
                label: 'Cart',
              ),
            ],
          );
        },
      ),
    );
  }
}