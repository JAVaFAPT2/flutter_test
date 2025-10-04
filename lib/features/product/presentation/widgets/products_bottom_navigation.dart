import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';

class ProductsBottomNavigation extends StatelessWidget {
  const ProductsBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigation(
      items: [
        BottomNavItem(
          icon: 'assets/figma_exports/cart_icon.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () => context.read<NavigationCubit>().navigateToCart(context),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/menu_box.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () =>
              context.read<NavigationCubit>().navigateToOrders(context),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/bell_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          badge: 1,
          onTap: () {
            // NOTE: Navigate to notifications page when implemented
          },
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/profile_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () =>
              context.read<NavigationCubit>().navigateToProfile(context),
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/figma_exports/home_menu.png',
        size: 65,
        innerSize: 45,
        iconSize: 26,
        onTap: () => context.read<NavigationCubit>().navigateToHome(context),
        backgroundColor: const Color(0xFF004917), // Dark green
      ),
      height: 85.0, // Slightly increased height for better spacing
      selectedIndex: 2, // No specific selection for products page
    );
  }
}
