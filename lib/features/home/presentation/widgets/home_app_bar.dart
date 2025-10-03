import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Home page app bar with logo, greeting, and avatar
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double baseWidth = 375.0; // iPhone X-ish baseline
    final double scale = MediaQuery.of(context).size.width / baseWidth;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
      child: Row(
        children: [
          // MGF Logo
          Image.asset(
            'assets/figma_exports/logo.png',
            width: 120 * scale,
            height: 54 * scale,
          ),

          SizedBox(width: 12 * scale),

          // MGF Healthy Choice text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'MGF',
                style: TextStyle(
                  fontSize: 20 * scale,
                  fontFamily: 'Gayathri',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  height: 1.22,
                ),
              ),
              Text(
                'HEALTHY CHOICE',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontFamily: 'Gayathri',
                  color: const Color(0xFFC80000),
                  fontWeight: FontWeight.w700,
                  height: 1.22,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Greeting
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Xin chào,',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontFamily: 'Poppins',
                    color: const Color(0xFF030303),
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  'Nguyen Van A',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13 * scale,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF900407),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8 * scale),

          // Avatar
          Container(
            width: 50 * scale,
            height: 50 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF900407),
              borderRadius: BorderRadius.circular(62 * scale),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(93 * scale),
              child: Padding(
                padding: EdgeInsets.all(3 * scale),
                child: Image.asset(
                  FigmaAssets.avatarDefault,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
