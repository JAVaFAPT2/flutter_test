import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Gallery section displaying featured images
class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGalleryImage(FigmaAssets.galleryImage1),
          _buildGalleryImage(FigmaAssets.galleryImage2),
          _buildGalleryImage(FigmaAssets.galleryImage3),
        ],
      ),
    );
  }

  Widget _buildGalleryImage(String imageUrl) {
    return Container(
      width: 105,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
