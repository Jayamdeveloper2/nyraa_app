// lib/providers/favorites_provider.dart

import 'package:flutter/foundation.dart';
import '../data/products_data.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get items => [..._favorites];

  bool isFavorite(int productId) {
    return _favorites.any((product) => product.id == productId);
  }

  void toggleFavorite(Product product) {
    final isExisting = _favorites.any((p) => p.id == product.id);

    if (isExisting) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  void removeFromFavorites(int productId) {
    _favorites.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}