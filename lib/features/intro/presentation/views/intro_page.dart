import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show base64Decode;
import 'dart:typed_data' show Uint8List;
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/src/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/app/routes/app_router.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/assets/figma_assets.dart';

/// Intro screen matching Figma design (Mở đầu app)
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  static const String routeName = '/intro';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image (PNG to avoid SVG load issues on some devices)
          Positioned.fill(
            child: Image.asset(
              kPngBackgroundIntro,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          // Top icons (left: Info circle, right: Globe) - match Figma positioning
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0x8CFEF9D9),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Opacity(
                  opacity: 0.49,
                  child: _EmbeddedPngFromSvg(
                      assetPath: kSvgInfoCircle, width: 23, height: 23),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0x8CFEF9D9),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: _EmbeddedPngFromSvg(
                    assetPath: kSvgWebIcon, width: 26, height: 26),
              ),
            ),
          ),
          // Content
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 96),
                    // Heading
                    Text(
                      'CHÀO MỪNG BẠN ĐẾN VỚI',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFFEF9D9),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Logo
                    SizedBox(
                      width: 289,
                      height: 164,
                      child: Image.asset(kPngLogoMgf, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tự hào cho - Tự hào nhận',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFFEF9D9),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 120),
                    // Bottle pack
                    SizedBox(
                      width: 158,
                      height: 200,
                      child: Image.asset(kPngProductPack, fit: BoxFit.contain),
                    ),
                    const Spacer(),
                    Text(
                      'Gia nhập MGF cùng chúng tôi để trải nghiệm\nnhững món ngon Việt - ĐẬM ĐÀ BẢN SẮC DÂN TỘC',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (kSvgRegisterFrame.isNotEmpty)
                          SvgPicture.asset(
                            kSvgRegisterFrame,
                            width: 306,
                            height: 54,
                          )
                        else
                          Container(
                            width: 306,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6A00),
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                        Text(
                          'ĐĂNG KÝ THÀNH VIÊN MỚI',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => context.push(AppRouter.register),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn đã có tài khoản rồi? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          onTap: () => context.push(AppRouter.login),
                          child: Text(
                            AppStrings.login.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders the first embedded base64 PNG found inside an SVG asset.
class _EmbeddedPngFromSvg extends StatelessWidget {
  const _EmbeddedPngFromSvg({required this.assetPath, this.width, this.height});
  final String assetPath;
  final double? width;
  final double? height;

  Future<Uint8List?> _loadPngBytes() async {
    try {
      final svg = await rootBundle.loadString(assetPath);
      // Try different regex patterns for embedded images
      final patterns = [
        RegExp(r'data:image/png;base64,([A-Za-z0-9+/=]+)'),
        RegExp(r'xlink:href="data:image/png;base64,([A-Za-z0-9+/=]+)"'),
        RegExp(r'href="data:image/png;base64,([A-Za-z0-9+/=]+)"'),
      ];

      for (final regex in patterns) {
        final match = regex.firstMatch(svg);
        if (match != null && match.group(1) != null) {
          final b64 = match.group(1)!;
          // Clean the base64 string
          final cleanB64 = b64.replaceAll(RegExp(r'[\s\n\r]'), '');
          try {
            return Uint8List.fromList(base64Decode(cleanB64));
          } catch (e) {
            // Continue to next pattern if decoding fails
            continue;
          }
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _loadPngBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.contain,
          );
        }
        // Fallback to SVG rendering if base64 not found
        return SvgPicture.asset(
          assetPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      },
    );
  }
}
