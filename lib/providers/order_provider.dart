// lib/providers/order_provider.dart
import 'package:flutter/foundation.dart';
import '../data/products_data.dart';
import '../pages/Profile/orders_page.dart';
import '../services/shared_prefs_service.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = true;

  OrderProvider() {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    _isLoading = true;
    notifyListeners();

    _orders = await SharedPrefsService.loadOrders();

    _isLoading = false;
    notifyListeners();
  }

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<Order> placeOrder(List<CartItem> cartItems, double total, String address) async {
    // Generate a random order ID
    final orderId = 'OD${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}';

    final orderItems = cartItems.map((item) => OrderItem(
      product: item.product,
      quantity: item.quantity,
      price: item.product.price,
    )).toList();

    final order = Order(
      id: orderId,
      items: orderItems,
      total: total,
      status: 'Processing',
      date: DateTime.now(),
      deliveryAddress: address,
    );

    _orders.add(order);
    await SharedPrefsService.saveOrders(_orders);
    notifyListeners();

    return order;
  }
}