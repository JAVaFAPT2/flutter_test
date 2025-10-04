import 'package:flutter/material.dart';

import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart';

/// Figma-style product card for products listing page
///
/// Matches Figma design with proper Flutter layout
/// Reusable component following DRY principles
class FigmaProductCard extends StatelessWidget {
  const FigmaProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 101,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product image
            _buildProductImage(),

            // Product details
            Expanded(
              child: _buildProductDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 128,
      height: 82,
      margin: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: product.imageUrl.isNotEmpty
            ? _buildImageWidget()
            : Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 40,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'No image',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildImageWidget() {
    // Check if it's a local asset or network URL
    if (product.imageUrl.startsWith('assets/')) {
      return Image.asset(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: const Icon(
            Icons.image,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    } else {
      return Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: const Icon(
            Icons.image,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Text(
            product.name,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4E3620),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Price info
          Text(
            '${product.originalPrice.toInt()},000 (VNĐ)/Chai. Chiết khấu: ${product.discountPercentage.toInt()}(%)',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 8,
              color: Color(0xFF989898),
            ),
          ),

          const SizedBox(height: 4),

          // Price
          Text(
            '${product.price.toInt()},000 VNĐ',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEA3125),
            ),
          ),

          const Spacer(),

          // Add to cart section
          _buildAddToCartSection(),
        ],
      ),
    );
  }

  Widget _buildAddToCartSection() {
    return Row(
      children: [
        // Add to cart button
        Expanded(
          child: GestureDetector(
            onTap: onAddToCart,
            child: Container(
              height: 17,
              decoration: BoxDecoration(
                color: Colors.brown[800],
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Center(
                child: Text(
                  'Thêm vào giỏ hàng',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Quantity controls
        Container(
          width: 59,
          height: 17,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // Implement quantity decrease
                },
                child: const Text('-', style: TextStyle(fontSize: 8)),
              ),
              const Text('01', style: TextStyle(fontSize: 8)),
              GestureDetector(
                onTap: () {
                  // Implement quantity increase
                },
                child: const Text('+', style: TextStyle(fontSize: 8)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
