// lib/services/shared_prefs_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/products_data.dart';
import '../pages/Profile/orders_page.dart';
import '../providers/cart_provider.dart';

class SharedPrefsService {
  static Future<void> saveOrders(List<Order> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = orders.map((order) => {
      'id': order.id,
      'items': order.items.map((item) => {
        'product': {
          'id': item.product.id,
          'image': item.product.image,
          'images': item.product.images,
          'name': item.product.name,
          'originalPrice': item.product.originalPrice,
          'price': item.product.price,
          'rating': item.product.rating,
          'discount': item.product.discount,
          'description': item.product.description,
          'size': item.product.size,
          'style': item.product.style,
          'material': item.product.material,
          'brand': item.product.brand,
          'availability': item.product.availability,
          'color': item.product.color,
          'category': item.product.category,
          'reviewCount': item.product.reviewCount,
          'sku': item.product.sku,
          'vendor': item.product.vendor,
          'topic': item.product.topic,
          'specifications': item.product.specifications,
          'about': item.product.about,
        },
        'quantity': item.quantity,
        'price': item.price,
      }).toList(),
      'total': order.total,
      'status': order.status,
      'date': order.date.toIso8601String(),
      'deliveryAddress': order.deliveryAddress,
    }).toList();
    await prefs.setString('orders', jsonEncode(ordersJson));
  }

  static Future<List<Order>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersString = prefs.getString('orders');
    if (ordersString == null) return [];

    final ordersJson = jsonDecode(ordersString) as List;
    return ordersJson.map((orderJson) => Order(
      id: orderJson['id'],
      items: (orderJson['items'] as List).map((itemJson) => OrderItem(
        product: Product(
          id: itemJson['product']['id'],
          image: itemJson['product']['image'],
          images: List<String>.from(itemJson['product']['images']),
          name: itemJson['product']['name'],
          originalPrice: itemJson['product']['originalPrice'].toDouble(),
          price: itemJson['product']['price'].toDouble(),
          rating: itemJson['product']['rating'].toDouble(),
          discount: itemJson['product']['discount'],
          description: itemJson['product']['description'],
          size: itemJson['product']['size'],
          style: itemJson['product']['style'],
          material: itemJson['product']['material'],
          brand: itemJson['product']['brand'],
          availability: itemJson['product']['availability'],
          color: itemJson['product']['color'],
          category: itemJson['product']['category'],
          reviewCount: itemJson['product']['reviewCount'],
          sku: itemJson['product']['sku'],
          vendor: itemJson['product']['vendor'],
          topic: itemJson['product']['topic'],
          specifications: Map<String, String>.from(itemJson['product']['specifications']),
          about: itemJson['product']['about'],
        ),
        quantity: itemJson['quantity'],
        price: itemJson['price'].toDouble(),
      )).toList(),
      total: orderJson['total'].toDouble(),
      status: orderJson['status'],
      date: DateTime.parse(orderJson['date']),
      deliveryAddress: orderJson['deliveryAddress'],
    )).toList();
  }

  static Future<void> saveFavoriteItems(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products.map((product) => {
      'id': product.id,
      'image': product.image,
      'images': product.images,
      'name': product.name,
      'originalPrice': product.originalPrice,
      'price': product.price,
      'rating': product.rating,
      'discount': product.discount,
      'description': product.description,
      'size': product.size,
      'style': product.style,
      'material': product.material,
      'brand': product.brand,
      'availability': product.availability,
      'color': product.color,
      'category': product.category,
      'reviewCount': product.reviewCount,
      'sku': product.sku,
      'vendor': product.vendor,
      'topic': product.topic,
      'specifications': product.specifications,
      'about': product.about,
    }).toList();
    await prefs.setString('favorites', jsonEncode(productsJson));
  }

  static Future<List<Product>> loadFavoriteItems() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString('favorites');
    if (favoritesString == null) return [];

    final favoritesJson = jsonDecode(favoritesString) as List;
    return favoritesJson.map((productJson) => Product(
      id: productJson['id'],
      image: productJson['image'],
      images: List<String>.from(productJson['images']),
      name: productJson['name'],
      originalPrice: productJson['originalPrice'].toDouble(),
      price: productJson['price'].toDouble(),
      rating: productJson['rating'].toDouble(),
      discount: productJson['discount'],
      description: productJson['description'],
      size: productJson['size'],
      style: productJson['style'],
      material: productJson['material'],
      brand: productJson['brand'],
      availability: productJson['availability'],
      color: productJson['color'],
      category: productJson['category'],
      reviewCount: productJson['reviewCount'],
      sku: productJson['sku'],
      vendor: productJson['vendor'],
      topic: productJson['topic'],
      specifications: Map<String, String>.from(productJson['specifications']),
      about: productJson['about'],
    )).toList();
  }

  static Future<void> saveCartItems(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cartItems.map((item) => {
      'product': {
        'id': item.product.id,
        'image': item.product.image,
        'images': item.product.images,
        'name': item.product.name,
        'originalPrice': item.product.originalPrice,
        'price': item.product.price,
        'rating': item.product.rating,
        'discount': item.product.discount,
        'description': item.product.description,
        'size': item.product.size,
        'style': item.product.style,
        'material': item.product.material,
        'brand': item.product.brand,
        'availability': item.product.availability,
        'color': item.product.color,
        'category': item.product.category,
        'reviewCount': item.product.reviewCount,
        'sku': item.product.sku,
        'vendor': item.product.vendor,
        'topic': item.product.topic,
        'specifications': item.product.specifications,
        'about': item.product.about,
      },
      'quantity': item.quantity,
    }).toList();
    await prefs.setString('cart', jsonEncode(cartJson));
  }

  static Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart');
    if (cartString == null) return [];

    final cartJson = jsonDecode(cartString) as List;
    return cartJson.map((itemJson) => CartItem(
      product: Product(
        id: itemJson['product']['id'],
        image: itemJson['product']['image'],
        images: List<String>.from(itemJson['product']['images']),
        name: itemJson['product']['name'],
        originalPrice: itemJson['product']['originalPrice'].toDouble(),
        price: itemJson['product']['price'].toDouble(),
        rating: itemJson['product']['rating'].toDouble(),
        discount: itemJson['product']['discount'],
        description: itemJson['product']['description'],
        size: itemJson['product']['size'],
        style: itemJson['product']['style'],
        material: itemJson['product']['material'],
        brand: itemJson['product']['brand'],
        availability: itemJson['product']['availability'],
        color: itemJson['product']['color'],
        category: itemJson['product']['category'],
        reviewCount: itemJson['product']['reviewCount'],
        sku: itemJson['product']['sku'],
        vendor: itemJson['product']['vendor'],
        topic: itemJson['product']['topic'],
        specifications: Map<String, String>.from(itemJson['product']['specifications']),
        about: itemJson['product']['about'],
      ),
      quantity: itemJson['quantity'],
    )).toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }
}