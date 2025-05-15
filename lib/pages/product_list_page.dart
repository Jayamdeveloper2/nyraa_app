import 'package:flutter/material.dart';
import '../data/products_data.dart'; // Import the product data
import 'filter_section.dart'; // Import the filter section
import '../buttons/buttons.dart'; // Import the buttons (AddToCartButton)
import '../pages/product_details_page.dart';

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
  List<String> appliedFilters = []; // To store applied filter labels

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

    // Generate applied filter labels
    List<String> tempFilters = [];
    if (filters['availability'].isNotEmpty) {
      tempFilters.add('Availability: ${filters['availability'].join(", ")}');
    }
    if (filters['priceRange']['min'] != 0 || filters['priceRange']['max'] != 50000) {
      tempFilters.add('Price: ₹${filters['priceRange']['min']} - ₹${filters['priceRange']['max']}');
    }
    if (filters['size'].isNotEmpty) {
      tempFilters.add('Size: ${filters['size'].join(", ")}');
    }
    if (filters['style'].isNotEmpty) {
      tempFilters.add('Style: ${filters['style'].join(", ")}');
    }
    if (filters['material'].isNotEmpty) {
      tempFilters.add('Material: ${filters['material'].join(", ")}');
    }
    if (filters['brand'].isNotEmpty) {
      tempFilters.add('Brand: ${filters['brand'].join(", ")}');
    }

    setState(() {
      filteredProducts = result;
      appliedFilters = tempFilters;
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
      body: SafeArea(
        child: Column(
          children: [
            // Filter Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  if (appliedFilters.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: appliedFilters.map((filter) {
                        return Chip(
                          label: Text(
                            filter,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Colors.grey[200],
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey,
                          ),
                          onDeleted: () {
                            setState(() {
                              appliedFilters.remove(filter);
                              if (filter.startsWith('Availability')) {
                                filters['availability'] = [];
                              } else if (filter.startsWith('Price')) {
                                filters['priceRange'] = {'min': 0, 'max': 50000};
                              } else if (filter.startsWith('Size')) {
                                filters['size'] = [];
                              } else if (filter.startsWith('Style')) {
                                filters['style'] = [];
                              } else if (filter.startsWith('Material')) {
                                filters['material'] = [];
                              } else if (filter.startsWith('Brand')) {
                                filters['brand'] = [];
                              }
                              applyFilters();
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
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
                    childAspectRatio: 0.60, // Increased to prevent overflow
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to product details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              productId: product.id.toString(), // Pass the product ID as a string
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1, // Square image to prevent overflow
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${product.rating}',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(width: 2),
                                          const Icon(Icons.star, size: 14, color: Colors.amber),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add to wishlist
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[300]!,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          child: Text(
                                            product.brand,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '₹${product.price.toStringAsFixed(0)}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (product.discount > 0)
                                              Text(
                                                '₹${product.originalPrice.toStringAsFixed(0)}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (product.discount > 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_upward,
                                                  color: Colors.green,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  '${product.discount}%',
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AddToCartButton(
                              onPressed: () {
                                // Add to cart logic here
                              },
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
      ),
    );
  }
}