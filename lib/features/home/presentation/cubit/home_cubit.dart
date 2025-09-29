import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for managing home page UI state
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void updateBannerIndex(int index) {
    emit(state.copyWith(currentBannerIndex: index));
  }
}

/// State for home page UI
class HomeState {
  const HomeState({
    this.currentBannerIndex = 0,
  });

  final int currentBannerIndex;

  HomeState copyWith({
    int? currentBannerIndex,
  }) {
    return HomeState(
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
    );
  }
}