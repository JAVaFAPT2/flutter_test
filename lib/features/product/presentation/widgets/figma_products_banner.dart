import 'package:flutter/material.dart';

/// Banner section for Figma-style products page
///
/// Contains promotional banner with call-to-action
/// Matches Figma design with proper Flutter layout
class FigmaProductsBanner extends StatelessWidget {
  const FigmaProductsBanner({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 115),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildBannerContent(),
              ),
              _buildBannerImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Đặt hàng ngay',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'hôm nay!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '"Món quà cho những người bạn"',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBannerImage() {
    return Container(
      width: 84,
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.card_giftcard,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
