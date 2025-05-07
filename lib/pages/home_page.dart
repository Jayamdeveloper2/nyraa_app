import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
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
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search 'Dresses'",
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 24,
                        height: 24,
                        color: const Color(0xFFBE6992),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // Address Selector Section
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddressBottomSheet(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFFBE6992)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Deliver to: 123 Main St, City, Country',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),

          // Popular Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _buildCategoryItem(context, 'assets/images/category/category1.jpg'),
                  _buildCategoryItem(context, 'assets/images/category/category2.jpg'),
                  _buildCategoryItem(context, 'assets/images/category/category3.jpg'),
                  _buildCategoryItem(context, 'assets/images/category/category4.jpg'),
                  _buildCategoryItem(context, 'assets/images/category/category5.jpg'),
                  _buildCategoryItem(context, 'assets/images/category/category6.jpg'),
                ],
              ),
            ),
          ),

          // Sliding Banner Section (Full Width)
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1.0, // Makes the carousel full-width
            ),
            items: [
              _buildBannerImage('assets/images/banner/banner1.jpg'),
              _buildBannerImage('assets/images/banner/banner2.jpg'),
            ],
          ),

          // Top Deals Section (Updated to 3x2 Grid)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Deals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 3, // 3 items per row
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Adjusted aspect ratio for better fit
                  children: [
                    _buildTopDealItem('Winter Wear', 'assets/images/topdeals/product1.jpg'),
                    _buildTopDealItem('Festive Wear', 'assets/images/topdeals/product2.jpg'),
                    _buildTopDealItem('Fashion Wear', 'assets/images/topdeals/product3.jpg'),
                    _buildTopDealItem('Western Wear', 'assets/images/topdeals/product4.jpg'),
                    _buildTopDealItem('Casual Wear', 'assets/images/topdeals/product1.jpg'),
                    _buildTopDealItem('Party Wear', 'assets/images/topdeals/product2.jpg'),
                  ],
                ),
              ],
            ),
          ),

          // Banner with gaps on left and right
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // 16 for a cleaner look
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/normalbanner/banner1.jpg',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,  
              ),
            ),
          ),


          // Products with Price Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Featured Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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

          // Flash Deals Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Flash Deals',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFBE6992),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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

  Widget _buildCategoryItem(BuildContext context, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Category',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerImage(String imagePath) {
    return Container(
      width: double.infinity, // Ensures full width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Top Deals',
              style: TextStyle(fontSize: 12, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashDealItem(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '-20%',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String imagePath, String price) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 14, color: Color(0xFFBE6992)),
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