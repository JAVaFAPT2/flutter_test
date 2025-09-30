import 'package:flutter/material.dart';

import '../../shared/widgets/smart_asset_image.dart';
import '../assets/figma_assets.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_router.dart';

/// Register page for Vietnamese fish sauce e-commerce app
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background - Use PNG since SVG doesn't exist
          const Positioned.fill(
            child: SmartAssetImage(
              assetPath: kPngRegisterBackground,
              fit: BoxFit.cover,
              preferSvg: false, // Use PNG directly
            ),
          ),

          // Right picture/graphic - positioned at the very top
          const Positioned(
            top: 0,
            right: 0,
            child: SmartAssetImage(
              assetPath: kPngRegisterRightPic,
              width: 150,
              height: 220,
              fit: BoxFit.contain,
              preferSvg: false, // Try PNG first, fallback to SVG
            ),
          ),

          // Back button - positioned according to Figma
          Positioned(
            top: 56,
            left: 23,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SmartAssetImage(
                assetPath: kPngRegisterLeftButton,
                width: 92,
                height: 55,
                preferSvg: false, // Try PNG first
              ),
            ),
          ),

          // Title "ĐĂNG KÝ" - positioned according to Figma
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ĐĂNG KÝ',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF935900),
                  fontFamily: 'KoHo',
                ),
              ),
            ),
          ),

          // Instruction text - positioned according to Figma
          Positioned(
            top: 343,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 250,
                child: Text(
                  'Vui lòng điền đầy đủ thông tin để tạo tài khoản mới!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF935900),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),

          // Green graphic accent - positioned according to Figma
          Positioned(
            top: 298,
            left: 0,
            right: 0,
            bottom: 0,
            child: SmartAssetImage(
              assetPath: kPngRegisterGraphicGreen,
              fit: BoxFit.cover,
              preferSvg: false, // Try PNG first for complex graphics
            ),
          ),

          // Full Name field - positioned exactly according to Figma
          Positioned(
            top: 515,
            left: 62,
            child: _buildYellowTextField(
              label: 'Họ và tên',
              hint: 'Nguyen Van A',
            ),
          ),

          // Phone field - positioned exactly according to Figma
          Positioned(
            top: 595,
            left: 62,
            child: _buildYellowTextField(
              label: 'Số điện thoại',
              hint: '0123456789',
            ),
          ),

          // Password field - positioned exactly according to Figma
          Positioned(
            top: 671,
            left: 62,
            child: _buildYellowTextField(
              label: 'Mật khẩu',
              hint: '********',
            ),
          ),

          // Register button - positioned exactly according to Figma
          Positioned(
            top: 783,
            left: 122,
            child: Container(
              width: 196,
              height: 51,
              child: ElevatedButton(
                onPressed: () {
                  // Handle register logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(93),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'ĐĂNG KÝ',
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

          // Login prompt: question text at left 74, top 854
          Positioned(
            top: 854,
            left: 74,
            child: SizedBox(
              width: 204,
              child: Text(
                'Bạn có tài khoản rồi?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),

          // Login prompt: CTA text at left 270, top 854
          Positioned(
            top: 854,
            left: 270,
            child: TextButton(
              onPressed: () {
                context.go(AppRouter.login);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'ĐĂNG NHẬP',
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

  Widget _buildYellowTextField({
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    double? width,
    double? height,
    Color? backgroundColor,
    Color? textColor,
    Color? labelColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    double? fontSize,
    double? labelFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontSize: labelFontSize ?? 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: width ?? 312,
          height: height ?? 42, // Exact height from Figma
          decoration: BoxDecoration(
            color: backgroundColor ??
                const Color(0xFFFEF9D9), // Cream color from Figma
            borderRadius: BorderRadius.circular(borderRadius ?? 57),
          ),
          child: TextField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(
              color: textColor ?? const Color(0xFF030303),
              fontSize: fontSize ?? 14, // Exact font size from Figma
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: textColor ?? const Color(0xFF030303),
                fontSize: fontSize ?? 14,
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 29,
                    vertical: 9, // Exact padding from Figma
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
