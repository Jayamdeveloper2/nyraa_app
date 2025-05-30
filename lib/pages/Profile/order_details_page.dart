// lib/pages/Profile/order_details_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/products_data.dart';
import '../../pages/Profile/orders_page.dart';
import '../../providers/order_provider.dart';
import 'invoice_page.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.orders.firstWhere(
          (o) => o.id == orderId,
      orElse: () => Order(
        id: '',
        items: [],
        total: 0,
        status: '',
        date: DateTime.now(),
        deliveryAddress: '',
      ),
    );

    if (order.id.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Order not found')),
      );
    }

    final estimatedDeliveryDate = order.date.add(const Duration(days: 7));
    final isReturnEligible = order.status == 'Delivered' &&
        DateTime.now().difference(order.date).inDays <= 30;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        title: Text(
          'Order #${order.id}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/orders');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderDetailsSection(order, estimatedDeliveryDate),
            const SizedBox(height: 16),
            _buildShippingAddressSection(order),
            const SizedBox(height: 16),
            _buildItemsSection(context, order),
            const SizedBox(height: 16),
            _buildSummarySection(order),
            const SizedBox(height: 24),
            _buildActionButtons(context, order, isReturnEligible),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailsSection(Order order, DateTime estimatedDeliveryDate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Order Date: ${_formatDate(order.date)}'),
          Text('Status: ${order.status}'),
          Text('Estimated Delivery: ${_formatDate(estimatedDeliveryDate)}'),
        ],
      ),
    );
  }

  Widget _buildShippingAddressSection(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(order.deliveryAddress),
        ],
      ),
    );
  }

  Widget _buildItemsSection(BuildContext context, Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Items',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...order.items.take(2).map((item) => _buildItemRow(context, item)),
          if (order.items.length > 2)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '+${order.items.length - 2} more items',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFBE6992),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Image.asset(
                    item.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 60),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.product.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '₹${item.price.toStringAsFixed(2)} × ${item.quantity}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(Order order) {
    final subtotal = order.total - 99.0 - (order.total * 0.18); // Adjust based on CartProvider
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildSummaryRow('Subtotal', subtotal),
          _buildSummaryRow('Shipping', 99.0),
          _buildSummaryRow('Tax (18%)', order.total * 0.18),
          _buildSummaryRow('Total', order.total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFFBE6992) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, Order order, bool isReturnEligible) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/invoice', arguments: {'order': order});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBE6992),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text('View Invoice'),
        ),
        ElevatedButton(
          onPressed: order.status == 'Processing'
              ? () {
            Provider.of<OrderProvider>(context, listen: false)
                .cancelOrder(order.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Order cancelled successfully'),
                backgroundColor: Color(0xFFBE6992),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushNamed(context, '/orders');
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text('Cancel Order'),
        ),
        if (isReturnEligible)
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Return feature coming soon!'),
                  backgroundColor: Color(0xFFBE6992),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text('Return Order'),
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}