import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Dynamic SVG timeline generator
/// Creates SVG content programmatically based on order tracking status
class DynamicTimelineSvg extends StatelessWidget {
  const DynamicTimelineSvg({
    super.key,
    required this.currentStatusIndex,
    required this.totalStatuses,
    this.width = 18,
    this.height = 480, // Maximum height for much longer timeline
  });

  final int currentStatusIndex;
  final int totalStatuses;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final svgContent = _generateSvgContent();

    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.string(
        svgContent,
        fit: BoxFit.contain,
      ),
    );
  }

  /// Generates SVG content dynamically based on current status
  String _generateSvgContent() {
    final buffer = StringBuffer();

    // SVG header
    buffer.writeln(
        '<svg width="$width" height="$height" viewBox="0 0 $width $height" fill="none" xmlns="http://www.w3.org/2000/svg">');

    // Generate timeline points and lines with proper Figma spacing
    for (int i = 0; i < totalStatuses; i++) {
      final isActive = i <= currentStatusIndex;

      // Calculate Y position with proper spacing to match Figma design
      // Maximum spacing for much longer timeline appearance
      final y = i * 75.0; // Much more spacing for even longer timeline

      // Add circle (timeline point) - 18x18 circle
      final color = isActive ? '#FF6B00' : '#8A8A8A';
      buffer.writeln(
          '<rect y="$y" width="18" height="18" rx="9" fill="$color"/>');

      // Add connecting line (except after last point)
      if (i < totalStatuses - 1) {
        final lineY = y + 18; // Start line after circle
        const lineHeight = 57.0; // Even longer lines for much longer timeline
        buffer.writeln(
            '<line x1="8.5" y1="$lineY" x2="8.5" y2="${lineY + lineHeight}" stroke="$color" stroke-width="1"/>');
      }
    }

    // Close SVG
    buffer.writeln('</svg>');

    return buffer.toString();
  }
}
