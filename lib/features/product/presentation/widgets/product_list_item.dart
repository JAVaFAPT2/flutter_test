import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/product_card.dart'
    as shared;
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

/// Product list item widget for horizontal list view in product feature
///
/// This widget is a thin wrapper around the existing ProductListItem from legacy
/// to follow DRY principles and avoid code duplication. It adds feature-specific
/// functionality while reusing the existing implementation.
///
/// Usage:
/// ```dart
/// ProductListItem(
///   product: product,
///   onTap: () => navigateToDetail(),
/// )
/// ```
class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductEntity product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Reuse shared ProductListItem implementation
    return shared.ProductListItem(
      product: product,
      onTap: onTap ?? () => _navigateToDetail(context),
    );
  }

  void _navigateToDetail(BuildContext context) {
    context.read<NavigationCubit>().navigateToProductDetail(context, product);
  }
}
