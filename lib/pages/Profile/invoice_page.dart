// lib/pages/Profile/invoice_page.dart
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../pages/Profile/orders_page.dart';

class InvoicePage extends StatelessWidget {
  final Order order;

  const InvoicePage({super.key, required this.order});

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Order Details',
                  style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Order #: ${order.id}'),
              pw.Text('Order Date: ${_formatDate(order.date)}'),
              pw.Text('Status: ${order.status}'),
              pw.Text(
                  'Estimated Delivery: ${_formatDate(order.date.add(const Duration(days: 7)))}'),
              pw.SizedBox(height: 20),
              pw.Text('Shipping Address:'),
              pw.Text(order.deliveryAddress),
              pw.SizedBox(height: 20),
              pw.Text('Items:'),
              ...order.items.map((item) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Text(
                    '${item.product.name} (x${item.quantity}) - ₹${(item.price * item.quantity).toStringAsFixed(2)}'),
              )),
              pw.SizedBox(height: 20),
              pw.Text('Subtotal: ₹${(order.total - 99.0 - (order.total * 0.18)).toStringAsFixed(2)}'),
              pw.Text('Shipping: ₹99.00'),
              pw.Text('Tax (18%): ₹${(order.total * 0.18).toStringAsFixed(2)}'),
              pw.Text('Total: ₹${order.total.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'order_${order.id}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        title: const Text(
          'Invoice',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Generate Invoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _generatePdf(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBE6992),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Download Invoice',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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