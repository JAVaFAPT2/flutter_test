import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

/// Header widget for order page with logo, greeting, and avatar
class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
    this.userName = 'Nguyen Van A',
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Logo (left)
          Image.asset(
            FigmaAssets.logoMgfNew,
            width: 82,
            height: 37,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'MGF',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC80000),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          // MGF branding text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MGF',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Gayathri',
                ),
              ),
              const Text(
                'HEALTHY CHOICE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC80000),
                  fontFamily: 'Gayathri',
                ),
              ),
            ],
          ),

          const Spacer(),

          // Greeting text (center)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.greeting,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF030303),
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF900407),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),

          // Avatar (right)
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: Container(
              width: 43,
              height: 43,
              decoration: const BoxDecoration(
                color: Color(0xFF900407),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  FigmaAssets.avatarUser,
                  width: 37,
                  height: 37,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
