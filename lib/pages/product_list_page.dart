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

  // Scroll controller for detecting scroll direction
  final ScrollController _scrollController = ScrollController();
  bool _isSortFilterVisible = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    applyFilters();

    // Add listener to detect scroll direction
    _scrollController.addListener(() {
      double currentOffset = _scrollController.offset;
      if (currentOffset > _lastOffset && currentOffset > 0) {
        // Scrolling down
        if (_isSortFilterVisible) {
          setState(() {
            _isSortFilterVisible = false;
          });
        }
      } else if (currentOffset < _lastOffset) {
        // Scrolling up
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

  void showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text(
                'Sort by Popularity',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  sortOption = 'bestSelling';
                  applyFilters();
                });
                Navigator.pop(context);
              },
              trailing: sortOption == 'bestSelling'
                  ? const Icon(Icons.check, color: Color(0xFFBE6992))
                  : null,
            ),
            ListTile(
              title: const Text(
                'Price: Low to High',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  sortOption = 'priceLowToHigh';
                  applyFilters();
                });
                Navigator.pop(context);
              },
              trailing: sortOption == 'priceLowToHigh'
                  ? const Icon(Icons.check, color: Color(0xFFBE6992))
                  : null,
            ),
            ListTile(
              title: const Text(
                'Price: High to Low',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  sortOption = 'priceHighToLow';
                  applyFilters();
                });
                Navigator.pop(context);
              },
              trailing: sortOption == 'priceHighToLow'
                  ? const Icon(Icons.check, color: Color(0xFFBE6992))
                  : null,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Added to Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE6992),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
              const SizedBox(height: 16),
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
                      childAspectRatio: 0.60,
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
                                        aspectRatio: 1,
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
                                                      child: const Text('Remove', style: TextStyle(color: Colors.red)),
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
                const SliverToBoxAdapter(
                  child: SizedBox(height: 60), // Adjust based on the height of the sort/filter bar
                ),
              ],
            ),
            // Sort and Filter section at the bottom
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _isSortFilterVisible ? 0 : -60,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.grey[50],
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sort Button
                    GestureDetector(
                      onTap: showSortBottomSheet,
                      child: Container(
                        width: (screenWidth - 24) / 2,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sort,
                              color: const Color(0xFFBE6992),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Sort',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Filter Button
                    GestureDetector(
                      onTap: showFilterBottomSheet,
                      child: Container(
                        width: (screenWidth - 24) / 2,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: const Color(0xFFBE6992),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
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
