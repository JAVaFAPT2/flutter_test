import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Custom widget that intelligently handles both SVG and PNG assets with automatic fallback
class SmartAssetImage extends StatelessWidget {
  final String assetPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool preferSvg;

  const SmartAssetImage({
    super.key,
    required this.assetPath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.preferSvg = true, // Try SVG first by default
  });

  @override
  Widget build(BuildContext context) {
    // Determine if we should try SVG first or PNG first
    final isSvgPath = assetPath.toLowerCase().endsWith('.svg');

    if (preferSvg && isSvgPath) {
      // Try SVG first, fallback to PNG if it fails
      return _buildSvgWithFallback(context);
    } else {
      // Try PNG first, fallback to SVG if needed
      return _buildPngWithFallback(context);
    }
  }

  Widget _buildSvgWithFallback(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to PNG version
        final pngPath = assetPath.replaceAll('.svg', '.png');
        return Image.asset(
          pngPath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            // Final fallback - show error placeholder
            return _buildErrorPlaceholder();
          },
        );
      },
    );
  }

  Widget _buildPngWithFallback(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to SVG version
        final svgPath = assetPath.replaceAll('.png', '.svg');
        return SvgPicture.asset(
          svgPath,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            // Final fallback - show error placeholder
            return _buildErrorPlaceholder();
          },
        );
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.broken_image,
          color: Colors.grey,
          size: 32,
        ),
      ),
    );
  }
}
