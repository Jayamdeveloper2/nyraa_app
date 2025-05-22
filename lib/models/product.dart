// lib/models/product.dart
class Product {
  final int id;
  final String image;
  final List<String> images;
  final String name;
  final double originalPrice;
  final double price;
  final double rating;
  final int discount;
  final String description;
  final String size;
  final String style;
  final String material;
  final String brand;
  final String availability;
  final String color;
  final String category;
  final int reviewCount;
  final String sku;
  final String vendor;
  final String topic;
  final Map<String, String> specifications;
  final String about;

  Product({
    required this.id,
    required this.image,
    required this.images,
    required this.name,
    required this.originalPrice,
    required this.price,
    required this.rating,
    required this.discount,
    required this.description,
    required this.size,
    required this.style,
    required this.material,
    required this.brand,
    required this.availability,
    required this.color,
    required this.category,
    required this.reviewCount,
    required this.sku,
    required this.vendor,
    required this.topic,
    required this.specifications,
    required this.about,
  });
}