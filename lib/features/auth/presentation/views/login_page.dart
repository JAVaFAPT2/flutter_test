import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/shared/widgets/smart_asset_image.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/auth_assets.dart';

/// Login page for Vietnamese fish sauce e-commerce app
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background - Same as register page for consistency
          const Positioned.fill(
            child: SmartAssetImage(
              assetPath: AuthAssets.backgroundLogin,
              fit: BoxFit.cover,
              preferSvg: false, // Use PNG since SVG doesn't exist
            ),
          ),

          // Right picture/graphic - positioned at the very top (same as register)
          const Positioned(
            top: 0,
            right: 0,
            child: SmartAssetImage(
              assetPath: AuthAssets.topRightLogin,
              width: 150,
              height: 220,
              fit: BoxFit.contain,
              preferSvg: false, // Try PNG first, fallback to SVG
            ),
          ),

          // Back button - Navigate back to intro page
          Positioned(
            top: 56,
            left: 23,
            child: GestureDetector(
              onTap: () {
                // Navigate back to intro page
                context.go('/intro');
              },
              child: const SmartAssetImage(
                assetPath: AuthAssets.backButtonLogin,
                width: 92,
                height: 55,
                preferSvg: false, // Try PNG first
              ),
            ),
          ),

          // Green accent area background - same as register for consistency
          const Positioned(
            top: 298,
            left: 0,
            right: 0,
            bottom: 0,
            child: SmartAssetImage(
              assetPath: AuthAssets.graphicGreenLogin,
              fit: BoxFit.cover,
              preferSvg: false, // Try PNG first for complex graphics
            ),
          ),

          // Title
          const Positioned(
            top: 330,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ĐĂNG NHẬP',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF935900),
                  fontFamily: 'KoHo',
                ),
              ),
            ),
          ),

          // Subtitle
          const Positioned(
            top: 390,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Vui lòng đăng nhập để tiếp tục quá trình mua hàng!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF935900),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),

          // Phone field
          const Positioned(
            top: 593,
            left: 62,
            child: _LoginTextField(
              label: 'Số điện thoại',
              hint: '0123456789',
              keyboardType: TextInputType.phone,
            ),
          ),

          // Password field
          const Positioned(
            top: 671,
            left: 62,
            child: _LoginTextField(
              label: 'Mật khẩu',
              hint: '********',
              obscureText: true,
            ),
          ),

          // Login button
          Positioned(
            top: 781,
            left: 122,
            child: SizedBox(
              width: 196,
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate directly to home page (no auth required)
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(93),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'KoHo',
                  ),
                ),
              ),
            ),
          ),

          // Register prompt
          const Positioned(
            top: 854,
            left: 74,
            child: SizedBox(
              width: 204,
              child: Text(
                'Bạn chưa có tài khoản?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),

          // Register CTA
          Positioned(
            top: 854,
            left: 270,
            child: TextButton(
              onPressed: () => context.push('/register'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'ĐĂNG KÝ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KoHo',
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simplified text field widget for login form
class _LoginTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;

  const _LoginTextField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 312,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xFFFEF9D9),
            borderRadius: BorderRadius.all(Radius.circular(57)),
          ),
          child: TextField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Color(0xFF030303),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF030303),
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 29, vertical: 9),
            ),
          ),
        ),
      ],
    );
  }
}
