import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading widget for product detail page
class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // Product Images Shimmer
          _buildProductImagesShimmer(context),

          // Product Details Shimmer
          _buildProductDetailsShimmer(context),

          // Back Button Shimmer
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerContainer(40, 40, borderRadius: 20),
                _buildShimmerContainer(40, 40, borderRadius: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImagesShimmer(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.4;

    return Container(
      height: imageHeight,
      color: Colors.grey.shade200,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProductDetailsShimmer(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.4;

    return Positioned(
      top: imageHeight - 30,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5DC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name Shimmer
              _buildShimmerContainer(200, 24, borderRadius: 4),
              const SizedBox(height: 8),

              // Subtitle Shimmer
              _buildShimmerContainer(150, 16, borderRadius: 4),
              const SizedBox(height: 16),

              // Price Shimmer
              _buildShimmerContainer(120, 28, borderRadius: 4),
              const SizedBox(height: 8),

              // Rating Shimmer
              Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index < 4 ? 4 : 0),
                    child: _buildShimmerContainer(20, 20, borderRadius: 10),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Description Shimmer
              _buildShimmerContainer(double.infinity, 14, borderRadius: 4),
              const SizedBox(height: 8),
              _buildShimmerContainer(double.infinity, 14, borderRadius: 4),
              const SizedBox(height: 8),
              _buildShimmerContainer(200, 14, borderRadius: 4),
              const SizedBox(height: 24),

              // Volume Selector Label Shimmer
              _buildShimmerContainer(100, 16, borderRadius: 4),
              const SizedBox(height: 12),

              // Volume Buttons Shimmer
              Row(
                children: [
                  _buildShimmerContainer(80, 36, borderRadius: 8),
                  const SizedBox(width: 12),
                  _buildShimmerContainer(80, 36, borderRadius: 8),
                  const SizedBox(width: 12),
                  _buildShimmerContainer(80, 36, borderRadius: 8),
                ],
              ),
              const SizedBox(height: 24),

              // Quantity Selector Label Shimmer
              _buildShimmerContainer(80, 16, borderRadius: 4),
              const SizedBox(height: 12),

              // Quantity Selector Shimmer
              _buildShimmerContainer(120, 48, borderRadius: 8),
              const SizedBox(height: 24),

              // Total Price Bar Shimmer
              _buildShimmerContainer(double.infinity, 48, borderRadius: 8),
              const SizedBox(height: 16),

              // Add to Cart Button Shimmer
              _buildShimmerContainer(double.infinity, 56, borderRadius: 8),
              const SizedBox(height: 24),

              // Related Products Label Shimmer
              _buildShimmerContainer(150, 18, borderRadius: 4),
              const SizedBox(height: 12),

              // Related Products Shimmer
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: index < 2 ? 12 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerContainer(150, 100, borderRadius: 12),
                          const SizedBox(height: 8),
                          _buildShimmerContainer(120, 12, borderRadius: 4),
                          const SizedBox(height: 4),
                          _buildShimmerContainer(80, 14, borderRadius: 4),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContainer(double width, double height,
      {double borderRadius = 4}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
