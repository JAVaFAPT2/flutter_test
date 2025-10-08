import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_order_detail_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  domain.Order? _order;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final usecase = GetOrderDetailUseCase(
        OrderRepositoryImpl(FakeFirestore.instance),
      );
      final order = await usecase(widget.orderId);
      setState(() {
        _order = order;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết đơn hàng')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _order == null
                  ? const Center(child: Text('Không tìm thấy đơn hàng'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mã đơn: ${_order!.code}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              'Ngày đặt: ${_order!.createdAt.day.toString().padLeft(2, '0')}/${_order!.createdAt.month.toString().padLeft(2, '0')}/${_order!.createdAt.year}'),
                          const SizedBox(height: 8),
                          Text('Trạng thái: ${_order!.status}'),
                          const SizedBox(height: 8),
                          Text(
                              'Tổng tiền: ${_order!.total.toStringAsFixed(0)} đ'),
                        ],
                      ),
                    ),
    );
  }
}
