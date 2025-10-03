import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// Events for FavoriteCubit
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FavoriteToggleRequested extends FavoriteEvent {
  const FavoriteToggleRequested(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

class FavoriteLoadRequested extends FavoriteEvent {
  const FavoriteLoadRequested();
}

/// States for FavoriteCubit
abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded({
    required this.favoriteIds,
    this.isLoading = false,
  });

  final Set<String> favoriteIds;
  final bool isLoading;

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  FavoriteLoaded copyWith({
    Set<String>? favoriteIds,
    bool? isLoading,
  }) {
    return FavoriteLoaded(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [favoriteIds, isLoading];
}

class FavoriteError extends FavoriteState {
  const FavoriteError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Cubit for managing favorite products
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteInitial()) {
    // Load initial favorites
    loadFavorites();
  }

  void toggleFavorite(String productId) {
    final currentState = state;
    if (currentState is FavoriteLoaded) {
      emit(currentState.copyWith(isLoading: true));

      // Simulate API call delay
      Future.delayed(const Duration(milliseconds: 300), () {
        final newFavorites = Set<String>.from(currentState.favoriteIds);

        if (newFavorites.contains(productId)) {
          newFavorites.remove(productId);
        } else {
          newFavorites.add(productId);
        }

        emit(FavoriteLoaded(
          favoriteIds: newFavorites,
          isLoading: false,
        ));
      });
    }
  }

  void loadFavorites() {
    // Simulate loading favorites from local storage or API
    Future.delayed(const Duration(milliseconds: 500), () {
      // For now, return empty set - will be populated from local storage later
      emit(const FavoriteLoaded(favoriteIds: {}));
    });
  }
}
