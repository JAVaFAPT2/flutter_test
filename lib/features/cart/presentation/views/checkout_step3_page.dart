import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/smart_asset_image.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_order_payment_header.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';

class CheckoutStep3Page extends StatelessWidget {
  const CheckoutStep3Page({super.key});

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
          // No green overlay on Step 3 (success screen)
          SafeArea(
            child: Column(
              children: [
                CustomOrderPaymentHeader(
                  title: AppStrings.orderInfoTitle,
                  currentStep: 3,
                  totalSteps: 3,
                  onBack: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Success check icon
                      Container(
                        width: 138,
                        height: 138,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(69),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                              color: const Color(0xFF0B8B50), width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.check,
                              size: 72, color: Color(0xFF0B8B50)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(
                        width: 280,
                        child: Text(
                          'Bạn đã đặt hàng\nthành công',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () => context.go('/order-tracking/mock_order_1'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Theo dõi đơn hàng',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Image.asset(
                              FigmaAssets.arrowRight,
                              width: 12,
                              height: 12,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 81,
                        height: 81,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0B8B50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.home,
                              color: Colors.white, size: 28),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => context.go('/home'),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chevron_left,
                                size: 18, color: Colors.black),
                            SizedBox(width: 4),
                            Text('Quay lại trang chủ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
