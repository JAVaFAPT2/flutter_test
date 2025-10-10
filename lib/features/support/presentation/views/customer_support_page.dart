import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_colors.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_support_header.dart';

/// Customer Support page matching Figma design (node 1-897)
/// Vietnamese fish sauce e-commerce app
class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  static const String routeName = '/customer-support';

  @override
  Widget build(BuildContext context) {
    return const _CustomerSupportView();
  }
}

class _CustomerSupportView extends StatelessWidget {
  const _CustomerSupportView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background - reuse global background asset
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // DRY header - reusable custom header
                const CustomSupportHeader(
                  title: 'Hỗ trợ tư vấn MGF',
                ),

                // Page content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Introduction Section
                        _buildIntroSection(),

                        const SizedBox(height: 20),

                        // Policy Options
                        _buildPolicyOptions(context),

                        const SizedBox(height: 20),

                        // Contact Section
                        _buildContactSection(),

                        const SizedBox(height: 120), // space for bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DRY bottom navigation
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBottomNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Bạn cần hỗ trợ vấn đề gì?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.cProfileTitleRed,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 8),
          // Description
          Text(
            'Cảm ơn Quý khách đã quan tâm đến sản phẩm của MGF. Chúng tôi giải đáp bất cứ thắc mắc/yêu cầu nào mà Quý khách cần.',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.cProfileTextGray,
              fontFamily: 'Poppins',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        children: [
          _buildPolicyBox(context, 'Chính sách đổi trả sản phẩm'),
          const SizedBox(height: 12),
          _buildPolicyBox(context, 'Chính sách giao hàng'),
          const SizedBox(height: 12),
          _buildPolicyBox(context, 'Thông tin nước mắm MGF'),
          const SizedBox(height: 12),
          _buildPolicyBox(context, 'Thông tin về MGF'),
        ],
      ),
    );
  }

  Widget _buildPolicyBox(BuildContext context, String text) {
    return InkWell(
      onTap: () {
        // Navigate to chat page with topic via extra (avoids encoding issues)
        context.push('/support-chat', extra: text);
      },
      child: Container(
        width: double.infinity,
        height: 31,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cProfileBorderGray),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.cProfileTextGray,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat with consultant
          _buildContactItem(
            icon: AppAssets.orderTrackingSupportIcon,
            iconSize: 16,
            title: 'Trò chuyện với nhân viên tư vấn',
            titleColor: AppColors.cProfileTitleRed,
          ),
          const SizedBox(height: 8),
          // Hotline
          _buildContactItem(
            icon: Icons.phone,
            iconSize: 19,
            title: 'Hotline: ',
            titleBold: '0123456789',
            titleColor: AppColors.cProfileTitleRed,
          ),
          const SizedBox(height: 8),
          // Address
          _buildAddressItem(),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required dynamic icon,
    required double iconSize,
    required String title,
    String? titleBold,
    Color titleColor = Colors.black,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon with border circle
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: icon is IconData
              ? Icon(icon, size: iconSize, color: Colors.black)
              : Image.asset(icon, width: 11, height: iconSize),
        ),
        const SizedBox(width: 9),
        // Title
        Expanded(
          child: titleBold != null
              ? RichText(
                  text: TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      TextSpan(
                        text: titleBold,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                    fontFamily: 'Poppins',
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildAddressItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon with border circle
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.location_on, size: 16, color: Colors.black),
        ),
        const SizedBox(width: 9),
        // Address text
        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Địa chỉ showroom MGF\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.cProfileTitleRed,
                  ),
                ),
                TextSpan(
                  text:
                      '93/42 Hoàng Hoa Thám, Phường 6, Bình Thạnh, \nTP. Hồ Chí Minh, Việt Nam',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
