import 'package:flutter/material.dart';

// Product class to hold product details
class Product {
  final String name;
  final String imagePath;
  final String price;
  final String category;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.category,
  });
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // List of all products from HomePage
  final List<Product> allProducts = [
    // From Top Deals
    Product(
      name: 'Winter Wear',
      imagePath: 'assets/images/topdeals/product1.jpg',
      price: '\$24.99',
      category: 'Top Deals',
    ),
    Product(
      name: 'Festive Wear',
      imagePath: 'assets/images/topdeals/product2.jpg',
      price: '\$34.99',
      category: 'Top Deals',
    ),
    Product(
      name: 'Fashion Wear',
      imagePath: 'assets/images/topdeals/product3.jpg',
      price: '\$29.99',
      category: 'Top Deals',
    ),
    Product(
      name: 'Western Wear',
      imagePath: 'assets/images/topdeals/product4.jpg',
      price: '\$39.99',
      category: 'Top Deals',
    ),
    Product(
      name: 'Casual Wear',
      imagePath: 'assets/images/topdeals/product5.jpg',
      price: '\$19.99',
      category: 'Top Deals',
    ),
    Product(
      name: 'Party Wear',
      imagePath: 'assets/images/topdeals/product6.jpg',
      price: '\$44.99',
      category: 'Top Deals',
    ),
    // From Featured Products
    Product(
      name: 'Product 1',
      imagePath: 'assets/images/featuredproducts/product1.jpg',
      price: '\$29.99',
      category: 'Featured Products',
    ),
    Product(
      name: 'Product 2',
      imagePath: 'assets/images/featuredproducts/product2.jpg',
      price: '\$39.99',
      category: 'Featured Products',
    ),
    Product(
      name: 'Product 3',
      imagePath: 'assets/images/featuredproducts/product3.jpg',
      price: '\$19.99',
      category: 'Featured Products',
    ),
    Product(
      name: 'Product 4',
      imagePath: 'assets/images/featuredproducts/product4.jpg',
      price: '\$49.99',
      category: 'Featured Products',
    ),
  ];

  // Filter state
  String selectedCategory = 'All';

  // Filter products based on selected category
  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return allProducts;
    }
    return allProducts.where((product) => product.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        elevation: 4,
        title: const Text(
          'All Products',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter by Category:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: <String>['All', 'Top Deals', 'Featured Products']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: const Color(0xFFBE6992),
                  ),
                  iconEnabledColor: const Color(0xFFBE6992),
                ),
              ],
            ),
          ),

          // All Products Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
                children: filteredProducts.map((product) {
                  return _buildProductCard(
                    product.name,
                    product.imagePath,
                    product.price,
                    product.category,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String imagePath, String price, String category) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 14, color: Color(0xFFBE6992), fontWeight: FontWeight.w500),
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}