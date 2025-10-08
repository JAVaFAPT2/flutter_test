import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/smart_asset_image.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_order_payment_header.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

class CheckoutStep2Page extends StatelessWidget {
  const CheckoutStep2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: SmartAssetImage(
              assetPath: FigmaAssets.checkoutBackground,
              fit: BoxFit.cover,
              preferSvg: false,
            ),
          ),
          const Positioned(
            top: 298,
            left: 0,
            right: 0,
            bottom: 0,
            child: SmartAssetImage(
              assetPath: FigmaAssets.graphicGreen,
              fit: BoxFit.cover,
              preferSvg: false,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomOrderPaymentHeader(
                  currentStep: 2,
                  totalSteps: 3,
                  onBack: () => Navigator.of(context).pop(),
                  onStepTap: (step) {
                    if (step == 1) Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Chọn phương thức thanh toán',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const _InfoLine(
                          text:
                              'Mọi thông tin bảo mật và quyền riêng tư của Quý khách đều được bảo vệ!',
                        ),
                        const SizedBox(height: 16),
                        const _PaymentMethodListBox(children: [
                          _PaymentMethodTile(
                            title: AppStrings.cashOnDelivery,
                            subtitle: 'Thanh toán bằng tiền mặt khi nhận hàng',
                            badgeText: 'COD',
                            trailing: _TrailingType.radio,
                            selected: true,
                            inBox: true,
                          ),
                          _BoxDivider(),
                          _PaymentMethodTile(
                            title: 'Ví điện tử MoMo',
                            subtitle: '',
                            badgeImage: FigmaAssets.logoMoMo,
                            trailing: _TrailingType.plus,
                            inBox: true,
                          ),
                          _BoxDivider(),
                          _PaymentMethodTile(
                            title: 'ZaloPay',
                            subtitle: '',
                            badgeImage: FigmaAssets.logoZaloPay,
                            trailing: _TrailingType.plus,
                            inBox: true,
                          ),
                          _BoxDivider(),
                          _PaymentMethodTile(
                            title: 'Ứng dụng ngân hàng di động (VNPAY)',
                            subtitle: '',
                            badgeImage: FigmaAssets.logoVnPay,
                            trailing: _TrailingType.chevron,
                            inBox: true,
                          ),
                          _BoxDivider(),
                          _PaymentMethodTile(
                            title: 'Thẻ tín dụng/thẻ ghi nợ',
                            subtitle: '',
                            badgeIcon: Icons.credit_card,
                            trailing: _TrailingType.chevron,
                            inBox: true,
                          ),
                          _BoxDivider(),
                          _PaymentMethodTile(
                            title: 'Thẻ ATM nội địa',
                            subtitle: '',
                            badgeText: 'ATM',
                            trailing: _TrailingType.chevron,
                            inBox: true,
                          ),
                        ]),
                        const SizedBox(height: 8),
                        const Text(
                          'Các phương thức Ví điện tử/ Thẻ ATM/ Thẻ tín dụng sẽ được chúng tôi cập nhập trong thời gian sớm nhất',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _OrderSummaryCard(),
                        const SizedBox(height: 20),
                        SafeArea(
                          minimum: const EdgeInsets.only(bottom: 12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 63,
                            child: ElevatedButton(
                              onPressed: () {
                                GoRouter.of(context).go('/checkout-step3');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B00),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: const Text('ĐẶT HÀNG',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _TrailingType { radio, chevron, plus }

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.title,
    required this.subtitle,
    this.badgeText,
    this.badgeImage,
    this.badgeIcon,
    this.trailing = _TrailingType.chevron,
    this.selected = false,
    this.inBox = false,
  });

  final String title;
  final String subtitle;
  final String? badgeText;
  final String? badgeImage;
  final IconData? badgeIcon;
  final _TrailingType trailing;
  final bool selected;
  final bool inBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: selected ? const Color(0xFF0B8B50) : const Color(0xFFE6E6E6),
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(inBox ? 12 : 12),
          topRight: Radius.circular(inBox ? 12 : 12),
          bottomLeft: Radius.circular(inBox ? 12 : 12),
          bottomRight: Radius.circular(inBox ? 12 : 12),
        ),
        boxShadow: inBox
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          _buildBadge(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildTrailing(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    if (badgeImage != null && badgeImage!.isNotEmpty) {
      return Container(
        height: 18,
        width: 43,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        child: Image.asset(
          badgeImage!,
          height: 11,
          fit: BoxFit.contain,
        ),
      );
    }
    if (badgeIcon != null) {
      return Icon(badgeIcon, size: 20, color: const Color(0xFF004917));
    }
    final String text = badgeText ?? '';
    // Map text badges to Figma colors
    Color background;
    Color foreground;
    if (text.toUpperCase() == 'COD') {
      background = const Color(0xFF1196F5); // Figma blue
      foreground = Colors.white;
    } else if (text.toUpperCase() == 'ATM') {
      background = const Color(0xFF003066); // Figma dark blue
      foreground = Colors.white;
    } else {
      background = Colors.white;
      foreground = Colors.black;
    }
    return Container(
      height: 18,
      constraints: const BoxConstraints(minWidth: 43),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    switch (trailing) {
      case _TrailingType.radio:
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF0B8B50), width: 1),
          ),
          child: selected
              ? Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B8B50),
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox.shrink(),
        );
      case _TrailingType.plus:
        return Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Color(0xFF0B8B50),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
      case _TrailingType.chevron:
        return const Icon(Icons.chevron_right, size: 18, color: Colors.black);
    }
  }
}

class _PaymentMethodListBox extends StatelessWidget {
  const _PaymentMethodListBox({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _BoxDivider extends StatelessWidget {
  const _BoxDivider();
  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFEFEFEF));
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
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
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
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
            const Row(
              children: [
                Text('Tổng đơn hàng',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                Spacer(),
                // three dots could be added later if needed
              ],
            ),
            const SizedBox(height: 10),
            _row(context, AppStrings.orderPlacedDate, '15 Thg 10 2024'),
            const SizedBox(height: 8),
            _row(context, AppStrings.orderSubtotalLabel, '565,000đ',
                labelColor: const Color(0xFF00541A)),
            _row(context, AppStrings.orderDiscountPercentLabel, '0%',
                labelColor: const Color(0xFF00541A)),
            _row(context, AppStrings.orderDiscountLabel, '0đ',
                labelColor: const Color(0xFF00541A)),
            _row(context, 'Phí vận chuyển', '30,000đ',
                labelColor: const Color(0xFF00541A)),
            const Divider(height: 16),
            const Row(
              children: [
                Text(AppStrings.orderTotalShort,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                Spacer(),
                Text('595,000đ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String l, String r,
      {Color labelColor = Colors.black}) {
    return Row(
      children: [
        Text(l, style: TextStyle(fontSize: 14, color: labelColor)),
        const Spacer(),
        Text(r, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }
}
