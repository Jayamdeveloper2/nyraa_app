import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/products_data.dart';
import 'filter_section.dart';
import '../buttons/buttons.dart';
import '../pages/product_details_page.dart';
import '../providers/favorites_provider.dart';
import '../providers/cart_provider.dart';

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
  List<String> appliedFilters = [];

  final ScrollController _scrollController = ScrollController();
  bool _isSortFilterVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    applyFilters();

    _scrollController.addListener(() {
      final double currentOffset = _scrollController.offset;
      if (currentOffset > _lastOffset && currentOffset > 0) {
        if (_isSortFilterVisible) {
          setState(() {
            _isSortFilterVisible = false;
          });
        }
      } else if (currentOffset < _lastOffset) {
        if (!_isSortFilterVisible) {
          setState(() {
            _isSortFilterVisible = true;
          });
        }
      }
      _lastOffset = currentOffset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void applyFilters() {
    List<Product> result = [...allProducts];
    if (widget.category != null && widget.category!.toLowerCase() != 'all') {
      result = result.where((p) => p.category == widget.category!.toLowerCase()).toList();
    }

    if (filters['availability'].isNotEmpty) {
      result = result.where((p) => filters['availability'].contains(p.availability)).toList();
    }
    result = result.where((p) => p.price >= filters['priceRange']['min'] && p.price <= filters['priceRange']['max']).toList();
    if (filters['size'].isNotEmpty) {
      result = result.where((p) => filters['size'].any((size) => p.size.split(', ').contains(size))).toList();
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

    final List<String> tempFilters = [];
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

  void showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildSortOption('Sort by Popularity', 'bestSelling'),
            _buildSortOption('Price: Low to High', 'priceLowToHigh'),
            _buildSortOption('Price: High to Low', 'priceHighToLow'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title, String value) {
    final isSelected = sortOption == value;
    return InkWell(
      onTap: () {
        setState(() {
          sortOption = value;
          applyFilters();
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFBE6992).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFBE6992) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? const Color(0xFFBE6992) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFBE6992),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  void _showAddToCartBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Added to Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      product.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFBE6992),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE6992),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Go to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        elevation: 4,
        title: Container(
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
              hintText: 'Search Products',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Icon(
                  Icons.search,
                  color: Color(0xFFBE6992),
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
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              if (cartProvider.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorites');
                },
              ),
              if (favoritesProvider.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${favoritesProvider.items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (appliedFilters.isNotEmpty) ...[
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
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.50,  // Changed from 0.7 to 0.65 to make cards taller
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = filteredProducts[index];
                        final bool isFavorite = favoritesProvider.isFavorite(product.id);

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product-details',
                              arguments: {'productId': product.id.toString()},
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [  // Added shadow for premium look
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 0.8,  // Changed from 0.9 to 0.8 to make images taller
                                          child: Image.asset(
                                            product.image,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (isFavorite) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: const Text('Remove from Favorites'),
                                                    content: Text('Are you sure you want to remove ${product.name} from your favorites?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          favoritesProvider.removeFromFavorites(product.id);
                                                          Navigator.pop(context);
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            const SnackBar(
                                                              content: Text('Removed from favorites'),
                                                              backgroundColor: Color(0xFFBE6992),
                                                              duration: Duration(seconds: 1),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Remove',
                                                          style: TextStyle(color: Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                favoritesProvider.toggleFavorite(product);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Added to favorites'),
                                                    backgroundColor: Color(0xFFBE6992),
                                                    duration: Duration(seconds: 1),
                                                  ),
                                                );
                                              }
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
                                              child: Icon(
                                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                                color: isFavorite ? const Color(0xFFBE6992) : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          if (product.discount > 0) ...[
                                            const SizedBox(width: 4),
                                            Text(
                                              '₹${product.originalPrice.toStringAsFixed(0)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      if (product.discount > 0) ...[
                                        const SizedBox(width: 4),
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
                                    ],
                                  ),
                                ),
                                AddToCartButton(
                                  onPressed: () {
                                    cartProvider.addItem(product);
                                    _showAddToCartBottomSheet(context, product);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: filteredProducts.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
            // Replace the existing AnimatedPositioned widget in the first file with this:

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _isSortFilterVisible ? 0 : -80,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: showSortBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sort, color: Color(0xFFBE6992), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Sort',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: showFilterBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tune, color: Color(0xFFBE6992), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}