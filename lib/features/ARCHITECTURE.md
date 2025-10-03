# Vietnamese Fish Sauce App - Clean Architecture

## Overview
This project follows Clean Architecture principles with a feature-based modular structure.

## Project Structure

```
lib/
├── features/                    ← Feature modules (Clean Architecture)
│   ├── auth/
│   │   └── presentation/
│   │       ├── views/
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   └── otp_verification_page.dart
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       └── cubit/
│   │           ├── login_cubit.dart
│   │           └── otp_cubit.dart
│   │
│   ├── intro/
│   │   └── presentation/
│   │       └── views/
│   │           └── intro_page.dart
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── views/
│   │       │   └── home_page.dart      ← Figma-based design
│   │       ├── widgets/
│   │       │   ├── bottom_navigation.dart
│   │       │   ├── category_button.dart
│   │       │   ├── gallery_section.dart
│   │       │   ├── home_app_bar.dart
│   │       │   ├── home_banner.dart
│   │       │   └── product_card.dart
│   │       └── cubit/
│   │           └── home_cubit.dart
│   │
│   ├── cart/
│   │   └── presentation/
│   │       ├── views/
│   │       │   ├── cart_page.dart
│   │       │   └── checkout_page.dart
│   │       └── bloc/
│   │           ├── cart_bloc.dart
│   │           ├── cart_event.dart
│   │           └── cart_state.dart
│   │
│   ├── product/
│   │   └── presentation/
│   │       ├── views/
│   │       │   ├── products_page.dart
│   │       │   └── product_detail_page.dart
│   │       ├── bloc/
│   │       │   ├── product_bloc.dart
│   │       │   ├── product_event.dart
│   │       │   └── product_state.dart
│   │       └── cubit/
│   │           ├── product_detail_cubit.dart
│   │           └── products_view_cubit.dart
│   │
│   ├── profile/
│   │   └── presentation/
│   │       ├── views/
│   │       │   ├── profile_page.dart
│   │       │   └── settings_page.dart
│   │       └── cubit/
│   │           └── profile_cubit.dart
│   │
│   └── order/
│       └── presentation/
│           └── views/
│               ├── order_confirmation_page.dart
│               └── order_history_page.dart
│
├── shared/                      ← Shared/reusable components
│   └── widgets/
│       ├── custom_bottom_navigation.dart
│       ├── custom_bottom_navigation_example.dart
│       └── CUSTOM_BOTTOM_NAV_GUIDE.md
│
├── core/                        ← Core utilities and constants
│   ├── constants/
│   │   ├── figma_assets.dart
│   │   └── app_constants.dart
│   └── design_system/
│       └── app_theme.dart
│
└── src/                         ← Legacy structure (being phased out)
    ├── presentation/
    │   ├── routes/
    │   │   └── app_router.dart   ← Central routing
    │   └── assets/
    │       └── figma_assets.dart
    └── domain/
        └── entities/
            └── product.dart
```

## Clean Architecture Layers

### Presentation Layer
- **Views**: Page/Screen widgets
- **Widgets**: Reusable UI components specific to a feature
- **BLoC/Cubit**: State management

### Domain Layer (Future)
- **Entities**: Business objects
- **Use Cases**: Business logic
- **Repositories**: Abstract interfaces

### Data Layer (Future)
- **Models**: Data transfer objects
- **Repositories**: Concrete implementations
- **Data Sources**: Remote (API) and Local (DB)

## Feature Organization

### Each Feature Should Have:
```
features/[feature_name]/
├── presentation/
│   ├── views/          ← Pages/Screens
│   ├── widgets/        ← Feature-specific widgets
│   ├── bloc/           ← Complex state (BLoC pattern)
│   └── cubit/          ← Simple state (Cubit pattern)
├── domain/             ← Business logic (future)
└── data/               ← Data sources (future)
```

## Current Features

### 1. **Auth Feature**
- Login with phone + password
- Registration flow
- OTP verification
- State: AuthBloc, LoginCubit, OtpCubit

### 2. **Intro Feature**
- Onboarding/welcome screen
- Entry point before auth

### 3. **Home Feature** ✨ Figma-based
- Main landing page
- Product showcase
- Banner carousel
- Category filtering
- Custom bottom navigation
- State: HomeCubit

### 4. **Cart Feature**
- Shopping cart
- Checkout flow
- State: CartBloc

### 5. **Product Feature**
- Products listing
- Product detail view
- State: ProductBloc, ProductDetailCubit, ProductsViewCubit

### 6. **Profile Feature**
- User profile
- Settings
- State: ProfileCubit

### 7. **Order Feature**
- Order confirmation
- Order history
- (State management to be added)

## Routing Configuration

**File**: `lib/src/presentation/routes/app_router.dart`

All routes import from feature folders:
```dart
import '../../../features/auth/presentation/views/login_page.dart';
import '../../../features/home/presentation/views/home_page.dart';
// etc...
```

### Route Flow:
```
App Start
  ↓
Intro Page (/intro)
  ↓
Login (/login) or Register (/register)
  ↓
Home (/home)
  ↓
├── Products (/products)
│   └── Product Detail (/product-detail)
├── Cart (/cart)
│   └── Checkout (/checkout)
│       └── Order Confirmation (/order-confirmation)
├── Profile (/profile)
│   └── Settings (/settings)
└── Order History (/order-history)
```

## State Management

### BLoC Pattern
- **Complex state**: Auth, Cart, Product
- Multiple events and states
- Used for: Authentication, cart management, product catalog

### Cubit Pattern
- **Simple state**: Home, Profile, Login, OTP, Product views
- Single state object
- Used for: Page-level state, forms, simple flows

## Design System

### Based on Figma
- **Design URL**: https://www.figma.com/design/DTsoPQ2H2y71hG7ftpTQZk/
- **Frame**: Trang chủ (1:2896)
- **Assets**: `lib/core/constants/figma_assets.dart`

### Colors
- Primary Red: #C80000
- Dark Green: #004917
- Maroon: #900407
- Black: #030303
- White: #FFFFFF

### Typography
- Poppins (Regular 400, Bold 700)
- Gayathri (Bold 700) - for branding

## Shared Components

### Custom Bottom Navigation
- Reusable across all features
- 5-item layout with elevated center
- Badge support
- Documentation: `lib/shared/widgets/CUSTOM_BOTTOM_NAV_GUIDE.md`

## Adding a New Feature

1. **Create folder structure**:
```bash
lib/features/[new_feature]/
├── presentation/
│   ├── views/
│   ├── widgets/ (optional)
│   ├── bloc/ or cubit/
│   └── README.md
```

2. **Add route** in `app_router.dart`:
```dart
import '../../../features/[new_feature]/presentation/views/page.dart';

GoRoute(
  path: '/route-name',
  name: 'route-name',
  builder: (context, state) => const PageName(),
)
```

3. **Document** the feature in its README.md

4. **Use shared components** from `lib/shared/widgets/`

## Dependencies

### State Management
- `flutter_bloc: ^9.0.0` - BLoC pattern
- `bloc_concurrency: 0.3.0` - Concurrency utilities

### Navigation
- `go_router: ^14.2.3` - Declarative routing

### DI
- `get_it: ^7.7.0` - Service locator
- `injectable: ^2.5.0` - Code generation

### UI
- `flutter_svg: ^2.0.10+1` - SVG support
- `cached_network_image: ^3.4.0` - Image caching

## Best Practices

### 1. Feature Independence
- Features should be self-contained
- Minimal dependencies between features
- Shared code goes in `lib/shared/`

### 2. Import Organization
```dart
// Flutter imports
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_bloc/flutter_bloc.dart';

// Feature imports
import '../../../features/auth/...';

// Local imports
import '../widgets/...';
```

### 3. State Management
- Use BLoC for complex multi-event flows
- Use Cubit for simple single-state scenarios
- Keep business logic in domain layer (future)

### 4. File Naming
- `[name]_page.dart` - Full screen pages
- `[name]_widget.dart` - Reusable widgets
- `[name]_bloc.dart` - BLoC state management
- `[name]_cubit.dart` - Cubit state management
- `[name]_event.dart` - BLoC events
- `[name]_state.dart` - BLoC/Cubit states

### 5. Documentation
- Each feature has README.md
- Complex components have inline comments
- Shared components have usage guides

## Migration Status

### ✅ Completed
- Home feature (Figma-based)
- Auth feature (Login, Register, OTP)
- Intro feature
- Cart feature
- Product feature
- Profile feature
- Order feature
- Router configuration updated

### 📋 To Do
- Add domain layer for business logic
- Add data layer for repositories
- Add use cases
- Add unit tests per feature
- Add integration tests
- Add API integration
- Add local database

## Testing Strategy

### Unit Tests
```
test/features/[feature_name]/
├── presentation/
│   ├── bloc/
│   ├── cubit/
│   └── widgets/
```

### Widget Tests
```
test/widgets/
└── [feature_name]/
```

### Integration Tests
```
integration_test/
└── [feature_name]_test.dart
```

## Performance Considerations

- Lazy load features when possible
- Use const constructors
- Optimize image loading
- Implement pagination
- Cache network responses
- Use IndexedStack for bottom nav

## Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Library](https://bloclibrary.dev/)
- [Figma Design](https://www.figma.com/design/DTsoPQ2H2y71hG7ftpTQZk/)

## Changelog

### October 1, 2025
- ✅ Reorganized all features to Clean Architecture
- ✅ Moved all pages from `lib/src/presentation/pages/` to `lib/features/`
- ✅ Updated router imports
- ✅ Created architecture documentation
- ✅ Implemented Figma-based home page
- ✅ Created reusable custom bottom navigation

---

**Version**: 1.0.0  
**Last Updated**: October 1, 2025  
**Status**: 🚀 Production Ready (Clean Architecture implemented)

