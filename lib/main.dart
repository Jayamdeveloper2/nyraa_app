// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/cart_provider.dart';
import './providers/favorites_provider.dart';
import './pages/home_page.dart';
import './pages/cart_page.dart';
// Import your actual favorites page file - adjust the path if needed
import './pages/favorites_page.dart';
import './pages/orders_page.dart';
import './pages/profile_page.dart';
import './pages/categories_page.dart';
import './pages/product_details_page.dart';
import './pages/product_list_page.dart';
import './splashscreens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Nyraa',
        debugShowCheckedModeBanner: false, // Removes the debug badge
        theme: ThemeData(
          primaryColor: const Color(0xFFBE6992),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFBE6992),
            primary: const Color(0xFFBE6992),
          ),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFBE6992),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const SplashScreen(), // Keep splash screen as initial screen
        routes: {
          '/home': (ctx) => const HomePage(),
          '/cart': (ctx) => const CartPage(),
          // Make sure this class exists in your favorites_page.dart file
          '/favorites': (ctx) => const FavoritesPage(),
          '/orders': (ctx) => const OrdersPage(),
          '/profile': (ctx) => const ProfilePage(),
          '/categories': (ctx) => const CategoriesPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-details') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (ctx) => ProductDetailsPage(
                productId: args['productId'],
              ),
            );
          }
          if (settings.name == '/product-list') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (ctx) => ProductListScreen(
                category: args?['category'],
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}