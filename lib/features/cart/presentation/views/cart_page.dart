import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/cart_edit_toolbar.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/cart_checkout_section.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

/// Shopping cart page - Matching Figma design with consistent styling
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String routeName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    // Load cart on page init
    context.read<CartBloc>().add(const CartLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Green graphic element from Figma overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: -200, // raise crest higher
            child: Image.asset(
              FigmaAssets.graphicGreen,
              width: double.infinity,
              height: 700,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      if (cartState.items.isEmpty) {
                        return _buildEmptyCartView(context);
                      }

                      return Column(
                        children: [
                          const CartEditToolbar(),
                          _buildCartItemsList(cartState),
                          const CartCheckoutSection(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const Spacer(),
          // GIỎ HÀNG title
          const Text(
            'GIỎ HÀNG',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          // Avatar
          Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              color: Color(0xFF900407),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(CartState cartState) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: cartState.items.length,
        itemBuilder: (context, index) {
          return CartItemWidget(
            cartItem: cartState.items[index],
            cartState: cartState,
          );
        },
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
    return Column(
      children: [
        const CartEditToolbar(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.emptyCartHint,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF9E9E9E),
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
