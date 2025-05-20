import 'package:flutter/material.dart';
import '../pages/cart_page.dart'; // Import the cart page

// Add to Cart Button
class AddToCartButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddToCartButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {
        // Navigate to cart page if no custom onPressed is provided
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 36, // Reduced from 40
        decoration: const BoxDecoration(
          color: Color(0xFFBE6992),
          borderRadius: BorderRadius.zero, // Removed border radius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Buy Now Button
class BuyNowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BuyNowButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFFBE6992),
          borderRadius: BorderRadius.zero, // No border radius
        ),
        child: const Center(
          child: Text(
            'Buy Now',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// Apply Button for Filter Section
class ApplyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApplyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFBE6992),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Apply',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}