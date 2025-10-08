import 'package:flutter/material.dart';

/// Search and filter section for Figma-style products page
///
/// Contains filter button and search bar
/// Matches Figma design with proper Flutter layout
class FigmaProductsSearch extends StatelessWidget {
  const FigmaProductsSearch({
    super.key,
    this.onFilterTap,
    this.onSearchTap,
  });

  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Filter button
          _buildFilterButton(),

          const SizedBox(width: 14),

          // Search bar
          Expanded(
            child: _buildSearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return GestureDetector(
      onTap: onFilterTap,
      child: Container(
        width: 31,
        height: 31,
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(15.5),
        ),
        child: const Icon(
          Icons.tune,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: onSearchTap,
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.5),
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search,
              color: Colors.grey[600],
              size: 17,
            ),
            const SizedBox(width: 16),
            Text(
              'Tìm kiếm...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}







