// lib/widgets/custom_bottom_navbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return BottomNavigationBar(
      selectedItemColor: const Color(0xFFBE6992),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? const Color(0xFFBE6992) : Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                'assets/icons/shopping_cart.svg',
                width: 24,
                height: 24,
                color: currentIndex == 1 ? const Color(0xFFBE6992) : Colors.grey,
              ),
              if (cartProvider.items.isNotEmpty)
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Center(
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
                ),
            ],
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                'assets/icons/favourites.svg',
                width: 24,
                height: 24,
                color: currentIndex == 2 ? const Color(0xFFBE6992) : Colors.grey,
              ),
              if (favoritesProvider.items.isNotEmpty)
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Center(
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
                ),
            ],
          ),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/orders.svg',
            width: 24,
            height: 24,
            color: currentIndex == 3 ? const Color(0xFFBE6992) : Colors.grey,
          ),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/profile.svg',
            width: 24,
            height: 24,
            color: currentIndex == 4 ? const Color(0xFFBE6992) : Colors.grey,
          ),
          label: 'You',
        ),
      ],
    );
  }
}