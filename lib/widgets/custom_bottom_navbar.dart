// lib/widgets/custom_bottom_navbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          icon: SvgPicture.asset(
            'assets/icons/shopping_cart.svg',
            width: 24,
            height: 24,
            color: currentIndex == 1 ? const Color(0xFFBE6992) : Colors.grey,
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/favourites.svg',
            width: 24,
            height: 24,
            color: currentIndex == 2 ? const Color(0xFFBE6992) : Colors.grey,
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