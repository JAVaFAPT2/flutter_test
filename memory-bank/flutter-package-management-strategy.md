# Flutter Package Management Strategy

## RECOMMENDED APPROACH: Package-Based Dependencies

### Core Principle: Use Well-Maintained Pub Packages

pubspec.yaml dependencies with specific versions to ensure zero-warning policy compliance.

## REQUIRED PACKAGE DEPENDENCIES:

### DEV DEPENDENCIES (Development):
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: error
    todo: error
    deprecated_member_use: error
    avoid_print: error
```

### CORE DEPENDENCIES (Runtime):
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # STATE MANAGEMENT
  provider: ^6.1.1
  
  # NETWORKING
  dio: ^5.3.4
  
  # LOCAL STORAGE
  shared_preferences: ^2.2.2
  
  # NAVIGATION
  go_router: ^12.1.1
  
  # DEPENDENCY INJECTION
  get_it: ^7.6.4
  
  # IMAGE LOADING & CACHING
  cached_network_image: ^3.3.0
  
  # VIETNAMESE LOCALIZATION
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  
  # SECURE STORAGE
  flutter_secure_storage: ^9.0.0
  
  # JSON SERIALIZATION
  json_annotation: ^4.8.1
  
  # UI COMPONENTS
  flutter_svg: ^2.0.9
  
  # PERFORMANCE
  flutter_performance_monitoring: ^1.0.0
```

### CODE GENERATION DEPENDENCIES:
```yaml
dev_dependencies:
  # JSON CODE GENERATION
  json_serializable: ^6.7.1
  build_runner: ^2.4.7
  
  # AUTO ROUTE GENERATION
  auto_route_generator: ^7.3.2
  
  # DEPENDENCY INJECTION CODE GENERATION
  injectable_generator: ^2.3.2
```

## PACKAGE APPROACH vs MANUAL IMPLEMENTATION:

### Package-Based Implementation (RECOMMENDED):
```yaml
# Why packages:
✅ Battle-tested code with community support
✅ Automatic updates and security patches
✅ Well-documented APIs
✅ Built-in error handling and edge cases
✅ Performance optimizations
✅ Full test coverage
✅ Zero-warning policy compliance
✅ Regular maintenance from package authors
```

### Manual Implementation (NOT RECOMMENDED):
```yaml
❌ Reinventing the wheel
❌ More bugs and edge cases to handle
❌ Maintenance overhead
❌ Security vulnerabilities
❌ No community support
❌ Slower development
❌ Potential warnings/issues
❌ Testing burden
```

## SPECIFIC PACKAGE USAGE PATTERNS:

### 1. Provider State Management:
```dart
// Use provider package for state management
final productProvider = ChangeNotifierProvider<ProductNotifier>(
  create: (_) => ProductNotifier(),
  child: ProductScreen(),
);
```

### 2. Dio Network Client:
```dart
// Use dio package for HTTP requests
@injectable
class ApiService {
  late final Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.nuocmam.vn',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ));
    
    _dio.interceptors.add(LogInterceptor());
  }
}
```

### 3. Go Router Navigation:
```dart
// Use go_router package for navigation
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductDetailScreen(
        productId: state.pathParameters['id']!,
      ),
    ),
  ],
);
```

### 4. Cached Network Images:
```dart
// Use cached_network_image package
CachedNetworkImage(
  imageUrl: product.imageUrl,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (content, url, error) => const Icon(Icons.error),
  width: double.infinity,
  height: 200,
  fit: BoxFit.cover,
)
```

### 5. Vietnamese Localization:
```dart
// Use flutter_localizations package
MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('vi', 'VN'), // Vietnamese
    Locale('en', 'US'), // English fallback
  ],
  locale: Locale('vi', 'VN'),
  home: HomeScreen(),
);
```

## PACKAGE VERSION STRATEGY:

### Version Locking Strategy:
```yaml
# Use caret (^) for minor updates only
dio: ^5.3.4  # Allows 5.3.x but not 6.0.x

# Lock major version updates
flutter_lints: ^3.0.0  # Stable, well-tested version
provider: ^6.1.1       # Latest stable Provider
```

### Dependency Overrides (if needed):
```yaml
dependency_overrides:
  # Only if conflicts occur
  path: ^1.8.3
  collection: ^1.17.2
```

## AUTOMATED PACKAGE MANAGEMENT:

### Update Strategy:
```bash
./scripts/update_packages.sh
```

```bash
#!/bin/bash
# Auto-update packages with testing

flutter clean
flutter pub get
flutter pub deps
flutter analyze --fatal-infos
flutter test

if [ $? -eq 0 ]; then
  echo "Package update successful!"
  git add pubspec.lock
  git commit -m "deps: update packages with zero warnings"
else
  echo "Package update failed - reverting"
  git checkout pubspec.lock
fi
```

## PACKAGE SECURITY & COMPLIANCE:

### Package Analysis:
```bash
# Check for vulnerabilities
flutter pub deps
flutter pub upgrade --major-versions
flutter pub outdated
```

### Security Checklist:
- [ ] All packages are Flutter Favorite certified
- [ ] Packages have active maintenance
- [ ] No deprecated packages used
- [ ] Security vulnerabilities checked monthly
- [ ] Package licenses compatible with project

## MIGRATION STRATEGY:

### From Manual to Package-Based:
1. **Phase 1**: Replace custom implementations with packages
2. **Phase 2**: Leverage package features instead of building custom
3. **Phase 3**: Remove redundant custom code
4. **Phase 4**: Optimize using package-specific features

## CONCLUSION:

**USE PACKAGES** for all major functionality to ensure:
- Zero-warning policy compliance
- Faster development
- Better maintainability
- Security updates
- Performance optimizations
- Community support

**AVOID MANUAL IMPLEMENTATION** for standard functionality like HTTP, state management, navigation, and localization.