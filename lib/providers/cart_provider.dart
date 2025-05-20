// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../data/products_data.dart';
import '../services/shared_prefs_service.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = true;

  CartProvider() {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    _isLoading = true;
    notifyListeners();

    _items = await SharedPrefsService.loadCartItems();

    _isLoading = false;
    notifyListeners();
  }

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  double get tax => subtotal * 0.18; // 18% tax
  double get deliveryFee => _items.isEmpty ? 0 : 99.0;
  double get total => subtotal + tax + deliveryFee;

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex] = CartItem(
        product: _items[existingIndex].product,
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }

    _saveCartItems();
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _saveCartItems();
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index] = CartItem(
        product: _items[index].product,
        quantity: _items[index].quantity + 1,
      );
      _saveCartItems();
      notifyListeners();
    }
  }

  void decrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index] = CartItem(
          product: _items[index].product,
          quantity: _items[index].quantity - 1,
        );
      } else {
        _items.removeAt(index);
      }
      _saveCartItems();
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    SharedPrefsService.clearCart();
    notifyListeners();
  }

  Future<void> _saveCartItems() async {
    await SharedPrefsService.saveCartItems(_items);
  }
}