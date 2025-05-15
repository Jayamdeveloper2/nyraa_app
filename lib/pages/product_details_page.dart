import 'package:flutter/material.dart';
import '../data/products_data.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // Find the product by ID
    final product = allProducts.firstWhere((p) => p.id.toString() == productId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Add to wishlist logic
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Share logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: 3, // Assuming 3 images for carousel (you can adjust based on actual data)
                itemBuilder: (context, index) {
                  return Image.asset(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and Product Name
                  Text(
                    product.brand,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating and Reviews
                  Row(
                    children: [
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '(${product.reviewCount})',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFFBE6992),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (product.discount > 0)
                        Text(
                          '₹${product.originalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (product.discount > 0)
                        Row(
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Color Selection
                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColorOption(Colors.red, true),
                      const SizedBox(width: 8),
                      _buildColorOption(Colors.orange, false),
                      const SizedBox(width: 8),
                      _buildColorOption(Colors.grey, false),
                      const SizedBox(width: 8),
                      _buildColorOption(Colors.purple, false),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Size Selection
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSizeOption('S', product.size == 'S'),
                      const SizedBox(width: 8),
                      _buildSizeOption('M', product.size == 'M', outOfStock: true),
                      const SizedBox(width: 8),
                      _buildSizeOption('L', product.size == 'L'),
                      const SizedBox(width: 8),
                      _buildSizeOption('XL', product.size == 'XL'),
                      const SizedBox(width: 8),
                      _buildSizeOption('XXL', product.size == 'XXL'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Delivery Information
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Deliver To',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'U-block, Gurgaon 1220002',
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Delivery within 60-75 mins',
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'CHANGE',
                          style: TextStyle(color: Color(0xFFBE6992)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Product Details Tabs
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Color(0xFFBE6992),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFFBE6992),
                          tabs: [
                            Tab(text: 'SPECIFICATION'),
                            Tab(text: 'ABOUT'),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          child: TabBarView(
                            children: [
                              // Specification Tab
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Quantity: 1'),
                                    const SizedBox(height: 4),
                                    Text('Color: ${product.color}'),
                                    const SizedBox(height: 4),
                                    Text('Fabric: ${product.material}'),
                                    const SizedBox(height: 4),
                                    Text('Type: One Piece'),
                                    const SizedBox(height: 4),
                                    const Text('Detail: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.'),
                                  ],
                                ),
                              ),
                              // About Tab
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(product.description),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Customer Reviews
                  const Text(
                    'Customer Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${product.rating.toStringAsFixed(1)}/5',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            children: [
                              _buildRatingBar(5, 67),
                              _buildRatingBar(4, 23),
                              _buildRatingBar(3, 12),
                              _buildRatingBar(2, 8),
                              _buildRatingBar(1, 3),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${product.reviewCount} Reviews',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Photo Reviews
                  const Text(
                    'Photo Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3, // Adjust based on actual data
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            product.image,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sample Review
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Text('AP'),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Akansha Patel',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              Icon(Icons.star_border, color: Colors.amber, size: 14),
                              SizedBox(width: 4),
                              Text('4.0'),
                              SizedBox(width: 4),
                              Text('Good', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Awesome Product',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonummy.',
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Recommended Products
                  const Text(
                    'Recommended for you',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3, // Adjust based on actual data
                      itemBuilder: (context, index) {
                        final recommendedProduct = allProducts[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                recommendedProduct.image,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recommendedProduct.brand,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                recommendedProduct.name,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              if (recommendedProduct.discount > 0)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${recommendedProduct.discount}%',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFBE6992),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFBE6992)),
                  ),
                ),
                child: const Text('Add to Bag'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBE6992),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color, bool isSelected) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected ? const Border.fromBorderSide(BorderSide(color: Colors.black, width: 2)) : null,
      ),
      child: isSelected
          ? const Icon(
        Icons.check,
        color: Colors.white,
        size: 20,
      )
          : null,
    );
  }

  Widget _buildSizeOption(String size, bool isSelected, {bool outOfStock = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: outOfStock ? Colors.grey : (isSelected ? const Color(0xFFBE6992) : Colors.grey),
        ),
        borderRadius: BorderRadius.circular(8),
        color: outOfStock ? Colors.grey[200] : (isSelected ? const Color(0xFFBE6992).withOpacity(0.1) : Colors.white),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: outOfStock ? Colors.grey : (isSelected ? const Color(0xFFBE6992) : Colors.black),
        ),
      ),
    );
  }

  Widget _buildRatingBar(int stars, int percentage) {
    return Row(
      children: [
        Text('$stars'),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.amber, size: 14),
        const SizedBox(width: 4),
        SizedBox(
          width: 100,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              stars == 5
                  ? Colors.green
                  : stars == 4
                  ? Colors.yellow
                  : stars == 3
                  ? Colors.orange
                  : stars == 2
                  ? Colors.blue
                  : Colors.red,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text('$percentage%'),
      ],
    );
  }
}