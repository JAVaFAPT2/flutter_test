import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/auth_assets.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/smart_asset_image.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_order_payment_header.dart';

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
  final ValueNotifier<String> _selectedPaymentMethod =
      ValueNotifier<String>('cod'); // cod, bank_transfer, ewallet

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
    _selectedPaymentMethod.dispose();
    super.dispose();
  }

  void _initializeUserData() {
    final user = context.read<AuthBloc>().state.user;
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
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            // Swipe left to go to step 2
            context.push('/checkout-step2');
          }
        },
        child: Stack(
          children: [
            // Background (match Register)
            const Positioned.fill(
              child: SmartAssetImage(
                assetPath: AuthAssets.backgroundRegister,
                fit: BoxFit.cover,
                preferSvg: false,
              ),
            ),
            // Green overlay (match Register positioning)
            const Positioned(
              top: 520,
              left: 0,
              right: 0,
              bottom: 0,
              child: SmartAssetImage(
                assetPath: AuthAssets.graphicGreenRegister,
                fit: BoxFit.cover,
                preferSvg: false,
              ),
            ),

            SafeArea(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  if (cartState.items.isEmpty) {
                    return _buildEmptyCartView();
                  }

                  // Total will be computed from state directly below

                  return Column(
                    children: [
                      CustomOrderPaymentHeader(
                        currentStep: 1,
                        totalSteps: 3,
                        onStepTap: (step) {
                          if (step == 2) {
                            context.push('/checkout-step2');
                          }
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Subtitle per Figma: Bước 1 trong 3
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Bước 1 trong 3',
                                    style: TextStyle(
                                      color: Color(0xFF989793),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                // Section header like Figma
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Nhập thông tin đơn hàng',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F1F1F),
                                    ),
                                  ),
                                ),
                                _buildInfoLine(
                                    'Quý khách vui lòng điền đầy đủ và kiểm lại thông tin trước khi đặt hàng'),
                                const SizedBox(height: 8),
                                _buildDeliveryAddressForm(),
                                const SizedBox(height: 24),
                                // Step 1 does NOT include payment methods (moved to Step 2)
                                _buildSectionHeader(AppStrings.orderSummary),
                                _buildOrderSummary(context),
                                const SizedBox(height: 24),
                                _buildSectionHeader(
                                    '${AppStrings.orderNotes} (tùy chọn)'),
                                _buildOrderNotesField(),
                                const SizedBox(
                                    height: 80), // space for bottom bar
                              ],
                            ),
                          ),
                        ),
                      ),
                      _CheckoutCtaBottom(
                          onPlaceOrder: () => _goToStep2(context)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header moved to shared widget: CustomOrderPaymentHeader

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
              context.pushReplacement('/products');
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

  Widget _buildInfoLine(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            border: Border.all(color: const Color(0xFF04BE04), width: 0.5),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF04BE04),
              fontSize: 9,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryAddressForm() {
    InputDecoration pill({required String hint, IconData? icon}) =>
        InputDecoration(
          hintText: hint,
          prefixIcon: icon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 10, right: 6),
                  child: Icon(icon, color: Colors.black, size: 18),
                ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(52),
            borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(52),
            borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(52),
            borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(52),
            borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
          ),
          errorStyle: const TextStyle(color: Color(0xFFE53935), fontSize: 12),
        );

    return Column(
      children: [
        // Full Name (label + pill)
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              AppStrings.recipientFullNameLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 42,
          child: TextFormField(
            controller: _fullNameController,
            textAlignVertical: TextAlignVertical.center,
            decoration: pill(hint: 'Nguyen Van A', icon: Icons.person),
            validator: (value) => (value == null || value.isEmpty)
                ? 'Vui lòng nhập họ và tên'
                : null,
          ),
        ),

        const SizedBox(height: 22),

        // Phone (label + pill)
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              AppStrings.recipientPhoneLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 42,
          child: TextFormField(
            controller: _phoneController,
            textAlignVertical: TextAlignVertical.center,
            decoration: pill(hint: '0123456789', icon: Icons.phone),
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
        ),

        const SizedBox(height: 22),

        // Address (label + pill)
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              AppStrings.recipientAddressLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 42,
          child: TextFormField(
            controller: _addressController,
            textAlignVertical: TextAlignVertical.center,
            decoration: pill(hint: '81 Hoàng Hoa Thám', icon: Icons.home),
            validator: (value) => (value == null || value.isEmpty)
                ? 'Vui lòng nhập địa chỉ'
                : null,
          ),
        ),

        const SizedBox(height: 22),

        // Notes (label + rounded box)
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              AppStrings.recipientNotesLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFBBBBBB)),
          ),
          child: TextFormField(
            controller: _notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Bất cứ điều gì Quý khách muốn nhắn gửi\nđến chúng tôi',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Remember info checkbox + label
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD9D9D9), width: 0.5),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              AppStrings.rememberInfo,
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ],
        ),

        const SizedBox(height: 6),
        _buildInfoLine(
            'Mọi thông tin cá nhân của Quý khách đều được bảo mật theo chính sách quyền riêng tư của MGF'),
      ],
    );
  }

  // Payment methods are implemented in Step 2 screen.

  // _buildPaymentOption was used in Step 2; removed from Step 1 file.

  Widget _buildOrderSummary(BuildContext context) {
    final cartState = context.watch<CartBloc>().state;
    // Use selected items if any, otherwise use all items
    final itemsToShow = cartState.selectedItems.isNotEmpty
        ? cartState.selectedItems
        : cartState.items;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Cart Items Summary
            ...itemsToShow.map((item) {
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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

            // Total Summary styled per Figma
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  _summaryRow(
                      context, 'Ngày đặt hàng', _formatDate(DateTime.now())),
                  const SizedBox(height: 10),
                  _summaryRow(context, 'Tổng phụ',
                      '${cartState.selectedTotal.toStringAsFixed(0)}đ',
                      labelColor: const Color(0xFF00541A)),
                  _summaryRow(context, 'Chiết khấu', '0%',
                      labelColor: const Color(0xFF00541A)),
                  _summaryRow(context, 'Giảm giá', '0đ',
                      labelColor: const Color(0xFF00541A)),
                  _summaryRow(context, 'Phí vận chuyển', '30,000đ',
                      labelColor: const Color(0xFF00541A)),
                  const Divider(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Tổng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(cartState.selectedTotal + 30000).toStringAsFixed(0)}đ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) =>
      "${dt.day.toString().padLeft(2, '0')} Thg ${dt.month.toString().padLeft(2, '0')} ${dt.year}";

  Widget _summaryRow(BuildContext context, String label, String value,
      {Color labelColor = Colors.black}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: labelColor),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
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

  // _placeOrder method removed - not currently used

  void _goToStep2(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.push('/checkout-step2');
    } else {
      // If invalid, also go to step 2 per request after entering details
      context.push('/checkout-step2');
    }
  }
}

class _CheckoutCtaBottom extends StatelessWidget {
  const _CheckoutCtaBottom({required this.onPlaceOrder});
  final VoidCallback onPlaceOrder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(45, 8, 45, 16),
      child: SizedBox(
        height: 61,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPlaceOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text(
            'ĐẶT HÀNG',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
