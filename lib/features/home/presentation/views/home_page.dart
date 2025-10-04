import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_banner.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/product_card.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/bloc/product_bloc.dart'
    as pb;
import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/category_button.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/gallery_section.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';

/// Home page - Main landing page of the Vietnamese Fish Sauce app
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial load of products from fake DB
    context
        .read<pb.ProductBloc>()
        .add(const pb.ProductLoadRequested(limit: 10));
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                const HomeAppBar(),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Banner
                        const HomeBanner(),

                        const SizedBox(height: 18),

                        // Popular products section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mọi người đều thích!',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<NavigationCubit>()
                                      .navigateToProducts(context);
                                },
                                child: Row(
                                  children: [
                                    const Text(
                                      'Xem thêm',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      FigmaAssets.arrowRight,
                                      width: 14,
                                      height: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 13),

                        // Product cards driven by ProductBloc + loading/empty/error and snap pager
                        BlocBuilder<pb.ProductBloc, pb.ProductState>(
                          builder: (context, state) {
                            if (state.isLoading && state.products.isEmpty) {
                              return SizedBox(
                                height: 200,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  itemCount: 3,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) =>
                                      _ProductShimmer(),
                                ),
                              );
                            }

                            if (state.errorMessage != null &&
                                state.products.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      state.errorMessage!,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              );
                            }

                            if (state.products.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text('Không có sản phẩm'),
                                  ),
                                ),
                              );
                            }

                            final products = state.products;
                            return SizedBox(
                              height: 200,
                              child: _SnappingProductPager(products: products),
                            );
                          },
                        ),

                        const SizedBox(height: 25),

                        // Search bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 29,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F1F2),
                              borderRadius: BorderRadius.circular(57),
                              border: Border.all(
                                color: const Color(0xFF3C3C3C),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 7),
                                Image.asset(
                                  FigmaAssets.searchIcon,
                                  width: 17,
                                  height: 17,
                                ),
                                const SizedBox(width: 7),
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm kiếm...',
                                      hintStyle: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFBBBBBB),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                    ),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 17),

                        // Categories section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Danh mục',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF030303),
                                ),
                              ),
                              const SizedBox(height: 12),
                              BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      CategoryButton(
                                        label: 'Nổi bật',
                                        isSelected: state.selectedCategory ==
                                            HomeCategory.noiBat,
                                        hasNotification: true,
                                        onTap: () {
                                          context
                                              .read<HomeCubit>()
                                              .selectCategory(
                                                  HomeCategory.noiBat);
                                          context.read<pb.ProductBloc>().add(
                                                const pb.ProductFilterChanged(
                                                  category: null,
                                                ),
                                              );
                                          context.read<pb.ProductBloc>().add(
                                              const pb.ProductLoadRequested(
                                                  limit: 10));
                                        },
                                      ),
                                      const SizedBox(width: 20),
                                      CategoryButton(
                                        label: 'Xuân Thịnh Mậu',
                                        isSelected: state.selectedCategory ==
                                            HomeCategory.xuanThinhMau,
                                        onTap: () {
                                          context
                                              .read<HomeCubit>()
                                              .selectCategory(
                                                HomeCategory.xuanThinhMau,
                                              );
                                          context.read<pb.ProductBloc>().add(
                                                const pb.ProductFilterChanged(
                                                  brand: 'Xuân Thịnh Mậu',
                                                ),
                                              );
                                          context.read<pb.ProductBloc>().add(
                                              const pb.ProductLoadRequested(
                                                  limit: 10));
                                        },
                                      ),
                                      const SizedBox(width: 17),
                                      CategoryButton(
                                        label: 'Vĩnh Thái',
                                        isSelected: state.selectedCategory ==
                                            HomeCategory.vinhThai,
                                        onTap: () {
                                          context
                                              .read<HomeCubit>()
                                              .selectCategory(
                                                  HomeCategory.vinhThai);
                                          context.read<pb.ProductBloc>().add(
                                                const pb.ProductFilterChanged(
                                                  brand: 'Vĩnh Thái',
                                                ),
                                              );
                                          context.read<pb.ProductBloc>().add(
                                              const pb.ProductLoadRequested(
                                                  limit: 10));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 11),

                        // Gallery section
                        const GallerySection(),

                        const SizedBox(height: 100), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeBottomNavigation(),
          ),
        ],
      ),
    );
  }
}

// Removed old local VM product provider in favor of ProductBloc-driven list

class _ProductShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _SnappingProductPager extends StatefulWidget {
  const _SnappingProductPager({required this.products});
  final List<domain.Product> products;

  @override
  State<_SnappingProductPager> createState() => _SnappingProductPagerState();
}

class _SnappingProductPagerState extends State<_SnappingProductPager> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.55);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      padEnds: false,
      pageSnapping: true,
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final p = widget.products[index];
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 20 : 6,
            right: index == widget.products.length - 1 ? 20 : 6,
          ),
          child: ProductCard.simple(
            imageUrl: p.imageUrl,
            name: p.name,
            price: p.formattedPrice,
            isLiked: p.isFeatured,
            onTap: () {
              // Map old IDs to new figma-sample IDs for product detail
              String productId = p.id;
              if (p.id == '1') productId = 'figma-sample-1';
              if (p.id == '2') productId = 'figma-sample-2';
              if (p.id == '3') productId = 'sample-3';
              context
                  .read<NavigationCubit>()
                  .navigateToProductDetailById(context, productId);
            },
          ),
        );
      },
    );
  }
}
