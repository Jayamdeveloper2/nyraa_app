// lib/pages/orders_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/products_data.dart';
import '../../main.dart'; // Import for MainApp.navigatorKey
import '../../providers/order_provider.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime date;
  final String deliveryAddress;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.date,
    required this.deliveryAddress,
  });
}

class OrderItem {
  final Product product;
  final int quantity;
  final double price;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Switch to Home tab (index 0)
            MainApp.navigatorKey.currentState?.setCurrentIndex(0);
          },
        ),
      ),
      body: orderProvider.isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFBE6992),
        ),
      )
          : orderProvider.orders.isEmpty
          ? _buildEmptyOrders(context)
          : _buildOrdersList(context, orderProvider),
    );
  }

  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Place an order to see it here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Switch to Home tab (index 0)
              MainApp.navigatorKey.currentState?.setCurrentIndex(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBE6992),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Start Shopping',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, OrderProvider orderProvider) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orderProvider.orders.length,
      itemBuilder: (context, index) {
        final order = orderProvider.orders[index];
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.status,
                  style: TextStyle(
                    fontSize: 14,
                    color: order.status == 'Processing'
                        ? Colors.orange
                        : order.status == 'Delivered'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Placed on: ${_formatDate(order.date)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: ₹${order.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFBE6992),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'Items (${order.items.length})',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: order.items.take(2).map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '₹${item.price.toStringAsFixed(2)} x ${item.quantity}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (order.items.length > 2)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '+${order.items.length - 2} more items',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to order confirmation page
                  Navigator.pushNamed(
                    context,
                    '/order-confirmation',
                    arguments: {'orderId': order.id},
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFBE6992),
                  side: const BorderSide(color: Color(0xFFBE6992)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'View Order Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}