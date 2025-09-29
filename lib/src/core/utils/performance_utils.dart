import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  static Timer?
      _throttleTimer; // Reserved for future use (timer-based throttle)
  static DateTime? _lastThrottleCall;

  static void throttle(
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 100),
  }) {
    final DateTime now = DateTime.now();
    if (_lastThrottleCall == null ||
        now.difference(_lastThrottleCall!) > delay) {
      _lastThrottleCall = now;
      action();
    }
  }

  /// Memory-efficient batch processing (sequential, to limit peak memory)
  static Future<void> processListInBatches<T>(
    List<T> items,
    int batchSize,
    Future<void> Function(List<T> batch) processor,
  ) async {
    assert(batchSize > 0, 'batchSize must be greater than zero');
    for (int i = 0; i < items.length; i += batchSize) {
      final int endIndex =
          (i + batchSize > items.length) ? items.length : i + batchSize;
      final List<T> batch = items.sublist(i, endIndex);
      await processor(batch);
    }
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

  /// Optimize widget rebuilds using RepaintBoundary
  static Widget wrapWithRepaintBoundary({
    required Widget child,
    String? key,
  }) {
    return RepaintBoundary(
      key: key != null ? Key(key) : null,
      child: child,
    );
  }

  /// Create optimized scroll physics for smooth scrolling
  static ScrollPhysics getOptimizedScrollPhysics() {
    return const BouncingScrollPhysics(
      decelerationRate: ScrollDecelerationRate.normal,
    );
  }

  /// Check if animations can likely run at 60fps
  static bool canRun60fpsAnimations() {
    // Prefer platform dispatcher over deprecated window API
    final double devicePixelRatio = PlatformDispatcher.instance.views.isNotEmpty
        ? PlatformDispatcher.instance.views.first.devicePixelRatio
        : 2.0; // Conservative default
    return devicePixelRatio <= 2.0;
  }

  /// Schedule a one-off frame callback
  static void scheduleFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance.scheduleFrameCallback(callback);
  }

  /// Monitor frame timings; returns a disposer to stop monitoring
  static VoidCallback monitorFrameTimings(
    void Function(List<FrameTiming> timings) onTimings,
  ) {
    void listener(List<FrameTiming> timings) => onTimings(timings);
    SchedulerBinding.instance.addTimingsCallback(listener);
    return () => SchedulerBinding.instance.removeTimingsCallback(listener);
  }

  /// Optimize list view performance with proper keys
  static Key generateValueKey(String id) {
    return ValueKey<String>(id);
  }

  /// Batch widget updates for better performance
  static void batchUpdates(VoidCallback updates) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updates();
    });
  }

  /// Pre-warm image cache for better performance
  static Future<void> prewarmImageCache(
      String imageUrl, BuildContext context) async {
    try {
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (_) {
      // Image prewarming failed, continue silently
    }
  }

  /// Check if widget should rebuild based on performance considerations
  static bool shouldRebuild<T>(
    T oldValue,
    T newValue, {
    bool forceRebuild = false,
  }) {
    if (forceRebuild) return true;
    return oldValue != newValue;
  }

  /// Get optimal item extent for list views based on screen size (logical pixels)
  static double getOptimalItemExtent(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate optimal item height for smooth scrolling
    // Aim for ~10-12 items visible on screen
    final int optimalVisibleItems = screenHeight > 800 ? 12 : 10;
    final double estimatedItemHeight = screenHeight / optimalVisibleItems;

    return estimatedItemHeight; // Keep in logical pixels (do not multiply by DPR)
  }
}

/// Widget performance mixins for better optimization
mixin PerformanceMixin<T extends StatefulWidget> on State<T> {
  /// Debounced state update to prevent excessive rebuilds
  Timer? _debounceTimer;

  void debouncedSetState(
    VoidCallback fn, {
    Duration delay = const Duration(milliseconds: 16), // ~60fps
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, () {
      if (mounted) {
        setState(fn);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

/// Automatic keep alive base State for list items
abstract class AutoKeepAliveState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T> {
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateKeepAlive();
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
