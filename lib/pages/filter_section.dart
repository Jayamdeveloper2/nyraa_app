import 'package:flutter/material.dart';
import '../data/products_data.dart'; // Import the product data
import '../buttons/buttons.dart'; // Import the ApplyButton

class FilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onFilterChange;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.onFilterChange,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, dynamic> tempFilters;

  @override
  void initState() {
    super.initState();
    // Create a deep copy of the current filters
    tempFilters = Map.from(widget.currentFilters);
    tempFilters['priceRange'] = Map.from(widget.currentFilters['priceRange']);
    tempFilters['availability'] = List.from(widget.currentFilters['availability']);
    tempFilters['size'] = List.from(widget.currentFilters['size']);
    tempFilters['style'] = List.from(widget.currentFilters['style']);
    tempFilters['material'] = List.from(widget.currentFilters['material']);
    tempFilters['brand'] = List.from(widget.currentFilters['brand']);
  }

  void handleCheckboxChange(String category, String value) {
    setState(() {
      final List<String> categoryFilters = List.from(tempFilters[category]);
      if (categoryFilters.contains(value)) {
        categoryFilters.remove(value);
      } else {
        categoryFilters.add(value);
      }
      tempFilters[category] = categoryFilters;
    });
  }

  void handlePriceChange(String field, String value) {
    setState(() {
      tempFilters['priceRange'] = {
        ...tempFilters['priceRange'],
        field: int.tryParse(value) ?? (field == 'min' ? 0 : 50000),
      };
    });
  }

  void applyFilters() {
    widget.onFilterChange(tempFilters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Use allProducts directly since it's guaranteed to be non-null
    final List<Product> productList = allProducts;

    // Extract unique filter options with explicit steps
    final Set<String> availabilitySet = productList.map((p) => p.availability).toSet();
    final Set<String> sizeSet = productList.map((p) => p.size).toSet();
    final Set<String> styleSet = productList.map((p) => p.style).toSet();
    final Set<String> materialSet = productList.map((p) => p.material).toSet();
    final Set<String> brandSet = productList.map((p) => p.brand).toSet();

    final List<Map<String, String>> availabilityOptions = availabilitySet
        .map((value) => {'value': value, 'label': value})
        .toList();
    final List<Map<String, String>> sizeOptions = sizeSet
        .map((value) => {'value': value, 'label': value})
        .toList();
    final List<Map<String, String>> styleOptions = styleSet
        .map((value) => {'value': value, 'label': value})
        .toList();
    final List<Map<String, String>> materialOptions = materialSet
        .map((value) => {'value': value, 'label': value})
        .toList();
    final List<Map<String, String>> brandOptions = brandSet
        .map((value) => {'value': value, 'label': value})
        .toList();

    final Map<String, dynamic> filterOptions = {
      'availability': availabilityOptions,
      'size': sizeOptions,
      'style': styleOptions,
      'material': materialOptions,
      'brand': brandOptions,
      'priceRange': {
        'min': productList.isNotEmpty
            ? productList.map((p) => p.price).reduce((a, b) => a < b ? a : b).floor()
            : 0,
        'max': productList.isNotEmpty
            ? productList.map((p) => p.price).reduce((a, b) => a > b ? a : b).ceil()
            : 50000,
      },
    };

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.filter_list,
                                  color: Color(0xFFBE6992),
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Availability
                        const Text(
                          'Availability',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...filterOptions['availability']!
                            .where((option) => option['value'] == 'In Stock')
                            .map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: tempFilters['availability'].contains(option['value']),
                                  onChanged: (bool? value) {
                                    handleCheckboxChange('availability', option['value']);
                                  },
                                  activeColor: const Color(0xFFBE6992),
                                ),
                                Text(
                                  option['label']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),

                        // Price Range
                        const Text(
                          'Price (₹)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Min: ₹${filterOptions['priceRange']['min'].toStringAsFixed(0)} - Max: ₹${filterOptions['priceRange']['max'].toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'From',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey[200]!),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => handlePriceChange('min', value),
                                controller: TextEditingController(text: tempFilters['priceRange']['min'].toString()),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'To',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey[200]!),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => handlePriceChange('max', value),
                                controller: TextEditingController(text: tempFilters['priceRange']['max'].toString()),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Size
                        const Text(
                          'Size',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...filterOptions['size']!.map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: tempFilters['size'].contains(option['value']),
                                  onChanged: (bool? value) {
                                    handleCheckboxChange('size', option['value']);
                                  },
                                  activeColor: const Color(0xFFBE6992),
                                ),
                                Text(
                                  option['label']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),

                        // Style
                        const Text(
                          'Style',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...filterOptions['style']!.map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: tempFilters['style'].contains(option['value']),
                                  onChanged: (bool? value) {
                                    handleCheckboxChange('style', option['value']);
                                  },
                                  activeColor: const Color(0xFFBE6992),
                                ),
                                Text(
                                  option['label']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),

                        // Material
                        const Text(
                          'Material',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...filterOptions['material']!.map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: tempFilters['material'].contains(option['value']),
                                  onChanged: (bool? value) {
                                    handleCheckboxChange('material', option['value']);
                                  },
                                  activeColor: const Color(0xFFBE6992),
                                ),
                                Text(
                                  option['label']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16),

                        // Brand
                        const Text(
                          'Brand',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ...filterOptions['brand']!.map<Widget>((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: tempFilters['brand'].contains(option['value']),
                                  onChanged: (bool? value) {
                                    handleCheckboxChange('brand', option['value']);
                                  },
                                  activeColor: const Color(0xFFBE6992),
                                ),
                                Text(
                                  option['label']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApplyButton(
                  onPressed: applyFilters,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}