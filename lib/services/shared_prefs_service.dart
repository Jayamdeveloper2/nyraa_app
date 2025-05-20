// lib/services/shared_prefs_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/products_data.dart';
import '../pages/orders_page.dart';
import '../providers/cart_provider.dart';

class SharedPrefsService {
  static const String _cartKey = 'cart_items';
  static const String _favoritesKey = 'favorite_items';
  static const String _ordersKey = 'order_items';

  // Save cart items to SharedPreferences
  static Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonItems = items.map((item) => {
      'productId': item.product.id,
      'quantity': item.quantity,
    }).toList();
    await prefs.setString(_cartKey, jsonEncode(jsonItems));
  }

  // Load cart items from SharedPreferences
  static Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);

    if (jsonString == null) {
      return [];
    }

    final jsonItems = jsonDecode(jsonString) as List;
    return jsonItems.map((item) {
      final productId = item['productId'];
      final product = allProducts.firstWhere(
            (p) => p.id == productId,
        orElse: () => allProducts[0], // Fallback product
      );

      return CartItem(
        product: product,
        quantity: item['quantity'],
      );
    }).toList();
  }

  // Save favorite items to SharedPreferences
  static Future<void> saveFavoriteItems(List<Product> items) async {
    final prefs = await SharedPreferences.getInstance();
    final productIds = items.map((item) => item.id).toList();
    await prefs.setString(_favoritesKey, jsonEncode(productIds));
  }

  // Load favorite items from SharedPreferences
  static Future<List<Product>> loadFavoriteItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);

    if (jsonString == null) {
      return [];
    }

    final productIds = jsonDecode(jsonString) as List;
    return productIds.map((id) {
      return allProducts.firstWhere(
            (p) => p.id == id,
        orElse: () => allProducts[0], // Fallback product
      );
    }).toList();
  }

  // Save orders to SharedPreferences
  static Future<void> saveOrders(List<Order> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonOrders = orders.map((order) => {
      'id': order.id,
      'items': order.items.map((item) => {
        'productId': item.product.id,
        'quantity': item.quantity,
        'price': item.price,
      }).toList(),
      'total': order.total,
      'status': order.status,
      'date': order.date.toIso8601String(),
      'deliveryAddress': order.deliveryAddress,
    }).toList();

    await prefs.setString(_ordersKey, jsonEncode(jsonOrders));
  }

  // Load orders from SharedPreferences
  static Future<List<Order>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_ordersKey);

    if (jsonString == null) {
      return [];
    }

    final jsonOrders = jsonDecode(jsonString) as List;
    return jsonOrders.map<Order>((orderData) {
      final items = (orderData['items'] as List).map<OrderItem>((itemData) {
        final productId = itemData['productId'];
        final product = allProducts.firstWhere(
              (p) => p.id == productId,
          orElse: () => allProducts[0], // Fallback product
        );

        return OrderItem(
          product: product,
          quantity: itemData['quantity'],
          price: itemData['price'],
        );
      }).toList();

      return Order(
        id: orderData['id'],
        items: items,
        total: orderData['total'],
        status: orderData['status'],
        date: DateTime.parse(orderData['date']),
        deliveryAddress: orderData['deliveryAddress'],
      );
    }).toList();
  }

  // Clear all cart items
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}