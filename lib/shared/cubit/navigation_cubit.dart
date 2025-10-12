import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:equatable/equatable.dart';

import 'package:vietnamese_fish_sauce_app/features/product/domain/entities/product_entity.dart';

/// Navigation cubit for handling app navigation
///
/// This cubit centralizes navigation logic and follows clean architecture
/// by separating navigation concerns from UI components.
///
/// Usage:
/// ```dart
/// BlocProvider<NavigationCubit>(
///   create: (_) => NavigationCubit(),
///   child: MyWidget(),
/// )
///
/// // In widget
/// context.read<NavigationCubit>().navigateToProductDetail(product);
/// ```
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  /// Navigate to product detail page
  void navigateToProductDetail(BuildContext context, ProductEntity product) {
    context.push('/product-detail', extra: product);
    emit(state.copyWith(lastNavigation: NavigationType.productDetail));
  }

  /// Navigate to product detail by ID
  void navigateToProductDetailById(BuildContext context, String productId) {
    context.push('/product/$productId');
    emit(state.copyWith(lastNavigation: NavigationType.productDetail));
  }

  /// Navigate to cart page
  void navigateToCart(BuildContext context) {
    context.push('/cart');
    emit(state.copyWith(lastNavigation: NavigationType.cart));
  }

  /// Navigate to home page
  void navigateToHome(BuildContext context) {
    context.go('/home');
    emit(state.copyWith(lastNavigation: NavigationType.home));
  }

  /// Navigate to profile page
  void navigateToProfile(BuildContext context) {
    context.push('/profile');
    emit(state.copyWith(lastNavigation: NavigationType.profile));
  }

  /// Navigate to orders page
  void navigateToOrders(BuildContext context) {
    context.push('/orders');
    emit(state.copyWith(lastNavigation: NavigationType.orders));
  }

  /// Navigate back
  void navigateBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      emit(state.copyWith(lastNavigation: NavigationType.back));
    }
  }

  /// Navigate to products listing
  void navigateToProducts(BuildContext context) {
    context.push('/products');
    emit(state.copyWith(lastNavigation: NavigationType.products));
  }

  /// Navigate to checkout
  void navigateToCheckout(BuildContext context) {
    context.push('/checkout');
    emit(state.copyWith(lastNavigation: NavigationType.checkout));
  }

  /// Navigate to notifications page
  void navigateToNotifications(BuildContext context) {
    context.push('/notifications');
    emit(state.copyWith(lastNavigation: NavigationType.notifications));
  }
}

/// Navigation state
class NavigationState extends Equatable {
  const NavigationState({
    this.lastNavigation,
  });

  final NavigationType? lastNavigation;

  NavigationState copyWith({
    NavigationType? lastNavigation,
  }) {
    return NavigationState(
      lastNavigation: lastNavigation ?? this.lastNavigation,
    );
  }

  @override
  List<Object?> get props => [lastNavigation];
}

/// Navigation types
enum NavigationType {
  productDetail,
  cart,
  home,
  profile,
  orders,
  products,
  checkout,
  notifications,
  back,
}
