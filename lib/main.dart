// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/favorites_page.dart';
import 'pages/orders_page.dart';
import 'pages/profile_page.dart';
import 'pages/checkout_page.dart';
import 'pages/order_confirmation_page.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/order_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Fashion Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFBE6992),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBE6992)),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomePage(),
          '/cart': (context) => const CartPage(),
          '/favorites': (context) => const FavoritesPage(),
          '/orders': (context) => const OrdersPage(),
          '/profile': (context) => const ProfilePage(),
          '/checkout': (context) => const CheckoutPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/order-confirmation') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => OrderConfirmationPage(
                orderId: args['orderId'],
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}