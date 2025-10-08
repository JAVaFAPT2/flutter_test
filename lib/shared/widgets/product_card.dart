import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart'
    as cart_bloc;
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Shared ProductCard widget that can be used across all features
///
/// This widget consolidates the functionality from multiple ProductCard implementations
/// to follow DRY principles. It supports both simple and complex use cases.
///
/// Usage:
/// ```dart
/// // Simple usage (like home feature)
/// ProductCard(
///   imageUrl: product.imageUrl,
///   name: product.name,
///   price: product.formattedPrice,
///   onTap: () => navigateToDetail(),
/// )
///
/// // Full usage (like product feature)
/// ProductCard.fromProduct(
///   product: product,
///   onTap: () => navigateToDetail(),
///   showCartButton: true,
/// )
/// ```
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isLiked = false,
    this.onTap,
    this.showCartButton = false,
    this.product, // Optional full product entity
  });

  /// Constructor for simple usage (home feature style)
  const ProductCard.simple({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isLiked = false,
    this.onTap,
  })  : showCartButton = false,
        product = null;

  /// Constructor for full product entity usage (product feature style)
  const ProductCard.fromProduct({
    super.key,
    required this.product,
    this.onTap,
    this.showCartButton = false,
  })  : imageUrl = '',
        name = '',
        price = '',
        isLiked = false;

  final String imageUrl;
  final String name;
  final String price;
  final bool isLiked;
  final VoidCallback? onTap;
  final bool showCartButton;
  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    // Use full product implementation if product entity is provided
    if (product != null) {
      return _buildFullProductCard(context);
    }

    // Use simple implementation for basic usage
    return _buildSimpleProductCard(context);
  }

  /// Full product card implementation (from legacy ProductCard)
  Widget _buildFullProductCard(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: 'Sản phẩm ${product!.name}, giá ${product!.formattedPrice}',
      button: true,
      child: RepaintBoundary(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProductImage(
                  imageUrl: product!.imageUrl,
                  isOnSale: product!.isOnSale,
                  discount: product!.discountPercentage,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        _RatingRow(
                          rating: product!.rating,
                          reviewCount: product!.reviewCount,
                        ),
                        const Spacer(),
                        _PriceRow(product: product!),
                        if (showCartButton) ...[
                          const SizedBox(height: 8),
                          _AddToCartButton(product: product!),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Simple product card implementation (from home feature)
  Widget _buildSimpleProductCard(BuildContext context) {
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

// Reused sub-components from legacy implementation
class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.imageUrl,
    required this.isOnSale,
    required this.discount,
  });

  final String imageUrl;
  final bool isOnSale;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (BuildContext context, String url) =>
                const ColoredBox(color: Color(0xFFEAEAEA)),
            errorWidget: (BuildContext context, String url, Object error) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
        if (isOnSale)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '-$discount%',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({
    required this.rating,
    required this.reviewCount,
  });

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodySmall;

    return Row(
      children: [
        const Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: textStyle),
        const SizedBox(width: 4),
        Text('($reviewCount)', style: textStyle?.copyWith(color: Colors.grey)),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          product.formattedPrice,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        if (product.isOnSale)
          Text(
            product.formattedOriginalPrice,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () =>
            context.read<cart_bloc.CartBloc>().add(cart_bloc.CartItemAdded(
                  product: product,
                  quantity: 1,
                  unitPrice: product.volumePrices.values.firstOrNull ?? 0,
                )),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Thêm vào giỏ'),
      ),
    );
  }
}

/// Horizontal list item for product display (from legacy ProductListItem)
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
    final ThemeData theme = Theme.of(context);

    return Semantics(
      label: 'Sản phẩm ${product.name}, giá ${product.formattedPrice}',
      button: true,
      child: RepaintBoundary(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ListThumbnail(
                  imageUrl: product.imageUrl,
                  isOnSale: product.isOnSale,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      _RatingRow(
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                      ),
                      const SizedBox(height: 8),
                      _PriceRow(product: product),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => context
                              .read<cart_bloc.CartBloc>()
                              .add(cart_bloc.CartItemAdded(
                                product: product,
                                quantity: 1,
                                unitPrice:
                                    product.volumePrices.values.firstOrNull ??
                                        0,
                              )),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Thêm vào giỏ'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Thêm vào giỏ',
                  onPressed: () => context
                      .read<cart_bloc.CartBloc>()
                      .add(cart_bloc.CartItemAdded(
                        product: product,
                        quantity: 1,
                        unitPrice: product.volumePrices.values.firstOrNull ?? 0,
                      )),
                  icon: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListThumbnail extends StatelessWidget {
  const _ListThumbnail({
    required this.imageUrl,
    required this.isOnSale,
  });

  final String imageUrl;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 96,
            height: 96,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) =>
                  const ColoredBox(color: Color(0xFFEAEAEA)),
              errorWidget: (BuildContext context, String url, Object error) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
          ),
        ),
        if (isOnSale)
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'SALE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
