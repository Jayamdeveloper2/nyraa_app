import 'package:flutter/material.dart';
import '../data/products_data.dart'; // Import the product data
import 'filter_section.dart'; // Import the filter section

class ProductListScreen extends StatefulWidget {
  final String? category;

  const ProductListScreen({super.key, this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String sortOption = 'bestSelling';
  List<Product> filteredProducts = [];
  Map<String, dynamic> filters = {
    'availability': [],
    'priceRange': {'min': 0, 'max': 50000},
    'size': [],
    'style': [],
    'material': [],
    'brand': [],
  };

  @override
  void initState() {
    super.initState();
    applyFilters();
  }

  void applyFilters() {
    List<Product> result = [...allProducts];
    if (widget.category != null && widget.category!.toLowerCase() != 'all') {
      result = result.where((p) => p.category == widget.category!.toLowerCase()).toList();
    }

    // Apply filters
    if (filters['availability'].isNotEmpty) {
      result = result.where((p) => filters['availability'].contains(p.availability)).toList();
    }
    result = result.where((p) => p.price >= filters['priceRange']['min'] && p.price <= filters['priceRange']['max']).toList();
    if (filters['size'].isNotEmpty) {
      result = result.where((p) => filters['size'].contains(p.size)).toList();
    }
    if (filters['style'].isNotEmpty) {
      result = result.where((p) => filters['style'].contains(p.style)).toList();
    }
    if (filters['material'].isNotEmpty) {
      result = result.where((p) => filters['material'].contains(p.material)).toList();
    }
    if (filters['brand'].isNotEmpty) {
      result = result.where((p) => filters['brand'].contains(p.brand)).toList();
    }

    // Apply sorting
    switch (sortOption) {
      case 'priceLowToHigh':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'priceHighToLow':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'bestSelling':
      default:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    setState(() {
      filteredProducts = result;
    });
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        currentFilters: filters,
        onFilterChange: (updatedFilters) {
          setState(() {
            filters = updatedFilters;
            applyFilters();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Match HomePage background
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992), // Match HomePage AppBar color
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Products',
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Products",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child: Icon(
                        Icons.search,
                        color: const Color(0xFFBE6992),
                        size: 18,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    alignLabelWithHint: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: showFilterBottomSheet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.filter_list, color: Color(0xFFBE6992), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Filter',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: sortOption,
                    underline: const SizedBox(), // Remove default underline
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    items: const [
                      DropdownMenuItem(value: 'bestSelling', child: Text('Best Selling')),
                      DropdownMenuItem(value: 'priceLowToHigh', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'priceHighToLow', child: Text('Price: High to Low')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sortOption = value!;
                        applyFilters();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Product Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to product details
                    },
                    child: Container(
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
                          Stack(
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(product.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // Add to wishlist
                                  },
                                ),
                              ),
                              if (product.discount > 0)
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '-${product.discount}%',
                                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.brand,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  product.name,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(0)}', // Updated to USD
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFBE6992),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    if (product.discount > 0)
                                      Text(
                                        '\$${product.originalPrice.toStringAsFixed(0)}', // Updated to USD
                                        style: const TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${product.rating}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.star, size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      '(${product.reviewCount})',
                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}