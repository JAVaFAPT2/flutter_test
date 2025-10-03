import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/cubit/home_cubit.dart';

/// Promotional banner with swipeable carousel and indicators
class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final cubit = context.read<HomeCubit>();
      final nextIndex = (cubit.state.currentBannerIndex + 1) % 3;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      cubit.updateBannerIndex(nextIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 174,
            width: double.infinity,
            child: Listener(
              onPointerDown: (_) {
                _autoPlayTimer?.cancel();
              },
              onPointerUp: (_) {
                _startAutoPlay();
              },
              child: PageView.builder(
                controller: _pageController,
                pageSnapping: true,
                onPageChanged: (index) =>
                    context.read<HomeCubit>().updateBannerIndex(index),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const _BannerCard();
                },
              ),
            ),
          ),

          const SizedBox(height: 13),

          // Carousel indicators
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7.5),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentBannerIndex == index
                          ? const Color(0xFFC80000)
                          : const Color(0xFFBBBBBB),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF004917),
        borderRadius: BorderRadius.circular(15),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double baseHeight = 174.0; // original design baseline
          final double scale =
              (constraints.maxHeight > 0 ? constraints.maxHeight : baseHeight) /
                  baseHeight;

          return Stack(
            children: [
              // Text content
              Positioned(
                left: 18 * scale,
                top: 33 * scale,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ưu đãi đặc biệt,',
                      style: TextStyle(
                        fontSize: 22 * scale,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'NGAY HÔM NAY!',
                      style: TextStyle(
                        fontSize: 22 * scale,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFEF9D9),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8 * scale),
                    SizedBox(
                      width: 173 * scale,
                      child: Text(
                        'Mọi người đều thích, "Món quà" dành tặng người thân yêu!',
                        style: TextStyle(
                          fontSize: 10 * scale,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Order button
              Positioned(
                right: 17 * scale,
                top: 63 * scale,
                child: Container(
                  width: 99 * scale,
                  height: 27 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5 * scale),
                  ),
                  child: Center(
                    child: Text(
                      'Đặt hàng ngay',
                      style: TextStyle(
                        fontSize: 10 * scale,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // Product image
              Positioned(
                right: 6 * scale,
                bottom: 2 * scale,
                child: Image.asset(
                  FigmaAssets.bannerProduct,
                  width: 149 * scale,
                  height: 98 * scale,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
