// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/favorites_page.dart';
import 'pages/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/order_confirmation_page.dart';
import 'pages/orders_page.dart';
import 'pages/product_details_page.dart';
import 'pages/profile_page.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/order_provider.dart';
import 'splashscreens/splash_screen.dart';
import 'widgets/custom_bottom_navbar.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/': (context) => const MainApp(),
          '/checkout': (context) => const CheckoutPage(),
          '/order-confirmation': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return OrderConfirmationPage(orderId: args['orderId']);
          },
          '/product-details': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return ProductDetailsPage(productId: args['productId']);
          },
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static final GlobalKey<_MainAppState> navigatorKey = GlobalKey<_MainAppState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const FavoritesPage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  void _onNavTap(int index) {
    print('MainApp: BottomNav tapped, index = $index'); // Debug
    setState(() {
      _currentIndex = index;
    });
  }

  void setCurrentIndex(int index) {
    print('MainApp: setCurrentIndex called with index = $index'); // Debug
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
      print('MainApp: Index set to $_currentIndex'); // Debug
    } else {
      print('MainApp: Cannot set index, widget not mounted'); // Debug
    }
  }

  @override
  Widget build(BuildContext context) {
    print('MainApp: Building with currentIndex = $_currentIndex'); // Debug
    return Scaffold(
      key: MainApp.navigatorKey,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}