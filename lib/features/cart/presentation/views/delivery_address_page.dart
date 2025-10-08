import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/smart_asset_image.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_order_payment_header.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/bloc/delivery_address_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/location_card.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/map_placeholder.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/widgets/instructions_card.dart';

class DeliveryAddressPage extends StatelessWidget {
  const DeliveryAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeliveryAddressBloc()..add(const LoadCurrentLocation()),
      child: const _DeliveryAddressView(),
    );
  }
}

class _DeliveryAddressView extends StatelessWidget {
  const _DeliveryAddressView();

  void _onMapTap(BuildContext context) {
    context.read<DeliveryAddressBloc>().add(const SelectLocationOnMap());

    // Show snackbar to indicate the change
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Địa chỉ đã được cập nhật'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFFC80000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const Positioned.fill(
            child: SmartAssetImage(
              assetPath: FigmaAssets.checkoutBackground,
              fit: BoxFit.cover,
              preferSvg: false,
            ),
          ),
          // Green overlay
          const Positioned(
            top: 298,
            left: 0,
            right: 0,
            bottom: 0,
            child: SmartAssetImage(
              assetPath: FigmaAssets.graphicGreen,
              fit: BoxFit.cover,
              preferSvg: false,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                CustomOrderPaymentHeader(
                  currentStep: 1,
                  totalSteps: 3,
                  onBack: () => Navigator.of(context).pop(),
                  onStepTap: (step) {
                    // Handle step navigation if needed
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Địa chỉ giao hàng',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Current address card using BLoC
                        BlocBuilder<DeliveryAddressBloc, DeliveryAddressState>(
                          builder: (context, state) {
                            return LocationCard(
                              address: state.currentAddress,
                              isLoading: state.isLoading,
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Google Maps placeholder
                        MapPlaceholder(
                          onTap: () => _onMapTap(context),
                        ),
                        const SizedBox(height: 24),

                        // Instructions card
                        const InstructionsCard(),
                        const SizedBox(height: 32),

                        // Continue button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to checkout step 2
                              context.push('/checkout-step2');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC80000),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Tiếp tục',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
