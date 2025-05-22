// lib/providers/favorites_provider.dart
import 'package:flutter/foundation.dart';
import '../data/products_data.dart';
import '../services/shared_prefs_service.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _items = [];
  bool _isLoading = true;

  FavoritesProvider() {
    _loadFavoriteItems();
  }

  Future<void> _loadFavoriteItems() async {
    _isLoading = true;
    notifyListeners();

    _items = await SharedPrefsService.loadFavoriteItems();

    _isLoading = false;
    notifyListeners();
  }

  List<Product> get items => _items;
  bool get isLoading => _isLoading;

  bool isFavorite(int productId) {
    return _items.any((item) => item.id == productId);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product.id)) {
      removeFromFavorites(product.id);
    } else {
      addToFavorites(product);
    }
  }

  void addToFavorites(Product product) {
    if (!isFavorite(product.id)) {
      _items.add(product);
      _saveFavoriteItems();
      notifyListeners();
    }
  }

  void removeFromFavorites(int productId) {
    _items.removeWhere((item) => item.id == productId);
    _saveFavoriteItems();
    notifyListeners();
  }

  Future<void> _saveFavoriteItems() async {
    await SharedPrefsService.saveFavoriteItems(_items);
  }
}
