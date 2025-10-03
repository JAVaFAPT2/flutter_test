import 'package:flutter_bloc/flutter_bloc.dart';

/// Simple product view model for Home listing
class HomeProductVm {
  const HomeProductVm({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.isLiked = false,
  });

  final String imageUrl;
  final String name;
  final String price;
  final bool isLiked;
}

enum HomeCategory { noiBat, xuanThinhMau, vinhThai }

/// Cubit for managing home page UI state
class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          const HomeState(),
        );

  void updateBannerIndex(int index) {
    emit(state.copyWith(currentBannerIndex: index));
  }

  void selectCategory(HomeCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }
}

/// State for home page UI
class HomeState {
  const HomeState({
    this.currentBannerIndex = 0,
    this.selectedCategory = HomeCategory.noiBat,
  });

  final int currentBannerIndex;
  final HomeCategory selectedCategory;

  HomeState copyWith({
    int? currentBannerIndex,
    HomeCategory? selectedCategory,
  }) {
    return HomeState(
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
