import 'package:flutter/material.dart';

/// Figma-style filter dropdown for product categories
///
/// Matches the design from Figma with proper styling and animations
class FigmaFilterDropdown extends StatelessWidget {
  const FigmaFilterDropdown({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?>? onCategorySelected;

  void _selectCategory(String category) {
    onCategorySelected?.call(category);
  }

  void _closeDropdown() {
    onCategorySelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dropdown menu
        Positioned(
          left: 44,
          top: 156,
          child: _buildDropdownMenu(),
        ),
      ],
    );
  }

  Widget _buildDropdownMenu() {
    return Container(
      width: 124,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with close button
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _closeDropdown,
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.46),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Category items
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;

            return Column(
              children: [
                GestureDetector(
                  onTap: () => _selectCategory(category),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (index < categories.length - 1)
                  Container(
                    height: 0.5,
                    color: Colors.black.withValues(alpha: 0.1),
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
