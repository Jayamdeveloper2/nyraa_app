// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/Profile/favorites_page.dart';
import 'pages/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/order_confirmation_page.dart';
import 'pages/Profile/orders_page.dart';
import 'pages/product_details_page.dart';
import 'pages/Profile/profile_page.dart';
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
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(
          primaryColor: const Color(0xFFBE6992),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBE6992)),
          useMaterial3: true,
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
          '/cart': (context) => const MainApp(initialIndex: 1),
          '/favorites': (context) => const MainApp(initialIndex: 2),
          '/home': (context) => const MainApp(initialIndex: 0),
          '/orders': (context) => const MainApp(initialIndex: 3),
          '/profile': (context) => const MainApp(initialIndex: 4),
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  final int initialIndex;

  const MainApp({super.key, this.initialIndex = 0});

  static final GlobalKey<_MainAppState> navigatorKey = GlobalKey<_MainAppState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const FavoritesPage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    print('MainApp: Index set to $_currentIndex');
  }

  void setCurrentIndex(int index) {
    print('MainApp: setCurrentIndex called with index = $index');
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
      print('MainApp: Index set to $_currentIndex');
    } else {
      print('MainApp: Cannot set index, widget not mounted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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