import 'dart:async';

/// Performance optimization utilities for the Vietnamese fish sauce e-commerce app
abstract class PerformanceUtils {
  /// Debounce function to prevent excessive API calls
  static Timer? _debounceTimer;

  static void debounce(
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, action);
  }

  /// Throttle function to limit function calls
  static Timer? _throttleTimer;
  static DateTime? _lastThrottleCall;

  static void throttle(
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 100),
  }) {
    final now = DateTime.now();
    if (_lastThrottleCall == null ||
        now.difference(_lastThrottleCall!) > delay) {
      _lastThrottleCall = now;
      action();
    }
  }

  /// Memory-efficient list processing
  static List<T> processListInBatches<T>(
    List<T> items,
    int batchSize,
    Future<void> Function(List<T> batch) processor,
  ) {
    final batches = <List<T>>[];
    for (var i = 0; i < items.length; i += batchSize) {
      final endIndex =
          i + batchSize > items.length ? items.length : i + batchSize;
      batches.add(items.sublist(i, endIndex));
    }
    return batches as List<T>;
  }

  /// Optimized image loading with caching
  static String getOptimizedImageUrl(String originalUrl, int targetSize) {
    // For placeholder images, return as-is
    if (originalUrl.contains('placeholder')) {
      return originalUrl;
    }

    // In a real app, you would modify the URL to request specific sizes
    // For now, return the original URL
    return originalUrl;
  }

  /// Check if device has sufficient memory for heavy operations
  static bool hasEnoughMemory() {
    // Simplified check - in a real app you'd check actual memory usage
    return true;
  }

  /// Preload critical resources
  static Future<void> preloadCriticalResources() async {
    // Preload commonly used images, fonts, etc.
    // This would be implemented based on specific app needs
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

/// Cache management utilities
abstract class CacheUtils {
  static const String _productCacheKey = 'cached_products';
  static const String _userProfileCacheKey = 'cached_user_profile';
  static const Duration _cacheDuration = Duration(hours: 1);

  /// Check if cached data is still valid
  static bool isCacheValid(String key) {
    // In a real implementation, you'd check timestamps
    return true;
  }

  /// Clear expired cache entries
  static void clearExpiredCache() {
    // Implementation would depend on your caching strategy
  }

  /// Get cached data with fallback
  static T? getCachedData<T>(String key, T Function() fallback) {
    if (isCacheValid(key)) {
      // Return cached data
      return fallback(); // Simplified for demo
    }
    return null;
  }
}
