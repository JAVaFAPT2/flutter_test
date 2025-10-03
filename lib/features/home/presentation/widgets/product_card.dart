import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Product card widget for displaying product information
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isLiked = false,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final String price;
  final bool isLiked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 166,
        height: 200,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product image
                SizedBox(
                  width: 146,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildProductImage(imageUrl),
                  ),
                ),

                const SizedBox(height: 3),

                // Product name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 2),

                // Product price
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            // Like button
            if (isLiked)
              Positioned(
                right: 16,
                top: -2,
                child: Image.asset(
                  FigmaAssets.likeIcon,
                  width: 29,
                  height: 29,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String url) {
    if ((url.startsWith('http://') || url.startsWith('https://')) &&
        !url.contains('via.placeholder.com')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          FigmaAssets.productXtm500ml,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      url,
      fit: BoxFit.cover,
    );
  }
}
