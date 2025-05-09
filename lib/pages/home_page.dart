import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'product_list_page.dart'; // Import the ProductListPage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/newlogo.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
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
                    hintText: "Search 'Dresses'",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 18,
                        height: 18,
                        color: const Color(0xFFBE6992),
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
              Icons.list,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductListPage()),
              );
            },
            tooltip: 'View All Products',
          ),
        ],
      ),
      body: ListView(
        children: [
          // Address Selector Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddressBottomSheet(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
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
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFFBE6992), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Deliver to: 123 Main St, City, Country',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),

          // Popular Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Popular Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      _buildCategoryItem(context, 'assets/images/category/category1.jpg', 'Dresses'),
                      _buildCategoryItem(context, 'assets/images/category/category2.jpg', 'Accessories'),
                      _buildCategoryItem(context, 'assets/images/category/category3.jpg', 'Bottoms'),
                      _buildCategoryItem(context, 'assets/images/category/category4.jpg', 'Tops'),
                      _buildCategoryItem(context, 'assets/images/category/category5.jpg', 'Footwear'),
                      _buildCategoryItem(context, 'assets/images/category/category6.jpg', 'Skirts'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Sliding Banner Section (Full Width)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  padEnds: false,
                ),
                items: [
                  _buildBannerImage('assets/images/banner/banner1.jpg'),
                  _buildBannerImage('assets/images/banner/banner2.jpg'),
                ],
              ),
            ),
          ),

          // Divider for Visual Separation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(color: Colors.grey[200]!, thickness: 1),
          ),

          // Top Deals Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Deals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                  children: [
                    _buildTopDealItem('Winter Wear', 'assets/images/topdeals/product1.jpg'),
                    _buildTopDealItem('Festive Wear', 'assets/images/topdeals/product2.jpg'),
                    _buildTopDealItem('Fashion Wear', 'assets/images/topdeals/product3.jpg'),
                    _buildTopDealItem('Western Wear', 'assets/images/topdeals/product4.jpg'),
                    _buildTopDealItem('Casual Wear', 'assets/images/topdeals/product5.jpg'),
                    _buildTopDealItem('Party Wear', 'assets/images/topdeals/product6.jpg'),
                  ],
                ),
              ],
            ),
          ),

          // Normal Banner Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200]!,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/normalbanner/banner1.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                ),
              ),
            ),
          ),

          // Divider for Visual Separation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(color: Colors.grey[200]!, thickness: 1),
          ),

          // Products with Price Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Featured Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                  children: [
                    _buildProductCard('Product 1', 'assets/images/featuredproducts/product1.jpg', '\$29.99'),
                    _buildProductCard('Product 2', 'assets/images/featuredproducts/product2.jpg', '\$39.99'),
                    _buildProductCard('Product 3', 'assets/images/featuredproducts/product3.jpg', '\$19.99'),
                    _buildProductCard('Product 4', 'assets/images/featuredproducts/product4.jpg', '\$49.99'),
                  ],
                ),
              ],
            ),
          ),

          // Divider for Visual Separation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(color: Colors.grey[200]!, thickness: 1),
          ),

          // Flash Deals Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Flash Deals',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      _buildFlashDealItem('assets/images/flashsale/product1.jpg'),
                      _buildFlashDealItem('assets/images/flashsale/product2.jpg'),
                      _buildFlashDealItem('assets/images/flashsale/product3.jpg'),
                      _buildFlashDealItem('assets/images/flashsale/product4.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFBE6992),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBE6992),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/category.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/category.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBE6992),
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/favourites.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/favourites.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBE6992),
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/orders.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/orders.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBE6992),
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBE6992),
            ),
            label: 'You',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String imagePath, String categoryName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!, width: 2),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            categoryName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerImage(String imagePath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTopDealItem(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Top Deals',
              style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashDealItem(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '-20%',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String imagePath, String price) {
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 14, color: Color(0xFFBE6992), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Address',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFFBE6992)),
            title: const Text('123 Main St, City, Country'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Color(0xFFBE6992)),
            title: const Text('456 Another St, City, Country'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}