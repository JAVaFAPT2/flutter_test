import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/loading_button.dart';

/// Checkout page for order placement
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Delivery address fields
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _wardController = TextEditingController();

  // Payment method
  String _selectedPaymentMethod = 'cod'; // cod, bank_transfer, ewallet

  // Order notes
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _initializeUserData() {
    final user = context.read<AuthProvider>().state.user;
    if (user != null) {
      _fullNameController.text = user.fullName;
      _phoneController.text = user.phone;
      if (user.address != null) {
        _addressController.text = user.address!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.checkout),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.state.items.isEmpty) {
            return _buildEmptyCartView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address Section
                  _buildSectionHeader(AppStrings.deliveryAddress),
                  _buildDeliveryAddressForm(),

                  const SizedBox(height: 24),

                  // Payment Method Section
                  _buildSectionHeader(AppStrings.paymentMethod),
                  _buildPaymentMethodSelection(),

                  const SizedBox(height: 24),

                  // Order Summary Section
                  _buildSectionHeader(AppStrings.orderSummary),
                  _buildOrderSummary(cartProvider),

                  const SizedBox(height: 24),

                  // Order Notes Section
                  _buildSectionHeader('${AppStrings.orderNotes} (tùy chọn)'),
                  _buildOrderNotesField(),

                  const SizedBox(height: 32),

                  // Place Order Button
                  LoadingButton(
                    isLoading: false, // Loading state will be added in Phase 6
                    onPressed: _placeOrder,
                    child: Text(
                      '${AppStrings.placeOrder} - ${cartProvider.state.formattedTotalPrice}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.emptyCart,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Giỏ hàng của bạn đang trống',
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

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  Widget _buildDeliveryAddressForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Full Name
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: AppStrings.fullName,
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập họ và tên';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Phone
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: AppStrings.phoneNumber,
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              if (value.length < 10 || value.length > 11) {
                return 'Số điện thoại không hợp lệ';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Address Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.address,
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // City, District, Ward Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.city,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tỉnh/thành phố';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.district,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập quận/huyện';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Ward
          TextFormField(
            controller: _wardController,
            decoration: const InputDecoration(
              labelText: AppStrings.ward,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập phường/xã';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildPaymentOption(
            'cod',
            AppStrings.cashOnDelivery,
            'Thanh toán bằng tiền mặt khi nhận hàng',
            Icons.local_shipping,
          ),
          const SizedBox(height: 12),
          _buildPaymentOption(
            'bank_transfer',
            AppStrings.bankTransfer,
            'Chuyển khoản qua tài khoản ngân hàng',
            Icons.account_balance,
          ),
          const SizedBox(height: 12),
          _buildPaymentOption(
            'ewallet',
            AppStrings.ewallet,
            'Thanh toán qua ví điện tử',
            Icons.smartphone,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
      String value, String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPaymentMethod == value
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          width: _selectedPaymentMethod == value ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (selectedValue) {
          setState(() {
            _selectedPaymentMethod = selectedValue!;
          });
        },
        title: Text(
          title,
          style: TextStyle(
            fontWeight: _selectedPaymentMethod == value
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        subtitle: Text(subtitle),
        secondary: Icon(
          icon,
          color: _selectedPaymentMethod == value
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Cart Items Summary
          ...cartProvider.state.items.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '${item.quantity} x ${item.product.formattedPrice}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    item.formattedTotalPrice,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // Total Summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Tổng tiền hàng:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      '${cartProvider.state.totalPrice.toStringAsFixed(0)}₫',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Phí vận chuyển:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      '30.000₫',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Thuế VAT:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      '${(cartProvider.state.totalPrice * 0.1).toStringAsFixed(0)}₫',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  children: [
                    Text(
                      'Tổng cộng:',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '${(cartProvider.state.totalPrice * 1.1 + 30000).toStringAsFixed(0)}₫',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderNotesField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: _notesController,
        decoration: const InputDecoration(
          hintText: 'Ghi chú đặc biệt cho đơn hàng...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        maxLines: 3,
      ),
    );
  }

  void _placeOrder() {
    if (_formKey.currentState?.validate() == true) {
      // Order placement will be implemented in Phase 6
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đặt hàng thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to order confirmation
      Navigator.of(context).pushNamed('/order-confirmation');
    }
  }
}
