import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/product.dart';
import '../providers/cart_provider.dart';

/// Grid card to display a product in catalog
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showCartButton = false,
  });

  final Product product;
  final VoidCallback? onTap;
  final bool showCartButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Semantics(
      label: 'Sản phẩm ${product.name}, giá ${product.formattedPrice}',
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
                    imageUrl: product.imageUrl,
                    isOnSale: product.isOnSale,
                    discount: product.discountPercentage),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _RatingRow(
                            rating: product.rating,
                            reviewCount: product.reviewCount),
                        const Spacer(),
                        _PriceRow(product: product),
                        if (showCartButton) ...[
                          const SizedBox(height: 8),
                          _AddToCartButton(product: product),
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
}

/// List item layout for product rows
class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
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
                    imageUrl: product.imageUrl, isOnSale: product.isOnSale),
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
                          reviewCount: product.reviewCount),
                      const SizedBox(height: 8),
                      _PriceRow(product: product),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Thêm vào giỏ',
                  onPressed: () =>
                      context.read<CartProvider>().addToCart(product),
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

  final Product product;

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

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => context.read<CartProvider>().addToCart(product),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Thêm vào giỏ'),
      ),
    );
  }
}
