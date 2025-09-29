import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

/// Order history page for viewing past orders
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  static const String routeName = '/order-history';

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String _selectedFilter = 'all'; // all, pending, completed, cancelled

  // Mock order data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'MG001',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'delivered',
      'total': 285000,
      'items': 3,
      'paymentMethod': 'cod',
    },
    {
      'id': 'MG002',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'completed',
      'total': 156000,
      'items': 2,
      'paymentMethod': 'bank_transfer',
    },
    {
      'id': 'MG003',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'cancelled',
      'total': 98000,
      'items': 1,
      'paymentMethod': 'cod',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orderHistory),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Row(
              children: [
                _buildFilterChip('all', 'Tất cả'),
                const SizedBox(width: 8),
                _buildFilterChip('pending', 'Chờ xác nhận'),
                const SizedBox(width: 8),
                _buildFilterChip('completed', 'Hoàn thành'),
                const SizedBox(width: 8),
                _buildFilterChip('cancelled', 'Đã hủy'),
              ],
            ),
          ),

          // Order List
          Expanded(
            child: _orders.isEmpty
                ? _buildEmptyOrdersView()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return _buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == value,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? value : 'all';
        });
      },
    );
  }

  Widget _buildEmptyOrdersView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.orderEmpty,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Bạn chưa có đơn hàng nào',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/products');
            },
            child: const Text(AppStrings.continueShopping),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = _getStatusColor(order['status']);
    final statusText = _getStatusText(order['status']);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đơn hàng ${order['id']}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(order['date']),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Order Details
            Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  '${order['items']} sản phẩm',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.payment,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  _getPaymentMethodText(order['paymentMethod']),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Total and Actions
            Row(
              children: [
                Text(
                  'Tổng tiền: ${order['total'].toStringAsFixed(0)}₫',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _viewOrderDetails(order),
                  child: const Text('Xem chi tiết'),
                ),
                if (order['status'] == 'delivered') ...[
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => _reorder(order),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      AppStrings.reorder,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'preparing':
        return Colors.purple;
      case 'shipping':
        return Colors.indigo;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return AppStrings.pending;
      case 'confirmed':
        return AppStrings.confirmed;
      case 'preparing':
        return AppStrings.preparing;
      case 'shipping':
        return AppStrings.shipping;
      case 'delivered':
        return AppStrings.delivered;
      case 'cancelled':
        return AppStrings.cancelled;
      default:
        return 'Không xác định';
    }
  }

  String _getPaymentMethodText(String method) {
    switch (method) {
      case 'cod':
        return AppStrings.cashOnDelivery;
      case 'bank_transfer':
        return AppStrings.bankTransfer;
      case 'ewallet':
        return AppStrings.ewallet;
      default:
        return 'Không xác định';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.filters),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tất cả đơn hàng'),
              leading: Radio<String>(
                value: 'all',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Chờ xác nhận'),
              leading: Radio<String>(
                value: 'pending',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Đã hoàn thành'),
              leading: Radio<String>(
                value: 'completed',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Đã hủy'),
              leading: Radio<String>(
                value: 'cancelled',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    // Order details page will be implemented in Phase 7
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Xem chi tiết đơn hàng ${order['id']}')),
    );
  }

  void _reorder(Map<String, dynamic> order) {
    // Reorder functionality will be implemented in Phase 7
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đặt lại đơn hàng ${order['id']}')),
    );
  }
}
