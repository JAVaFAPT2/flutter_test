# Product Feature Documentation

## Overview

The Product feature implements a comprehensive product listing and detail system for the Vietnamese Fish Sauce e-commerce app. It follows Clean Architecture principles with clear separation of concerns.

## Architecture

### Domain Layer
- **Entities**: `ProductEntity` - Core business model representing fish sauce products
- **Repositories**: `ProductRepository` - Interface for data operations
- **Use Cases**: 
  - `GetProductsQuery` - Retrieve product lists with filtering
  - `GetProductDetailQuery` - Retrieve individual product details

### Application Layer
- **BLoCs**: 
  - `ProductListBloc` - Manages product listing state and operations
  - `ProductDetailBloc` - Manages individual product detail state

### Data Layer
- **Repository Implementation**: `ProductRepositoryImpl` - Fake implementation using FakeFirestore

### Presentation Layer
- **Pages**:
  - `ProductsPage` - Standard product listing with grid/list views
  - `FishSauceProductsPage` - **NEW** - Figma-accurate Vietnamese fish sauce listing
  - `ProductDetailPage` - Individual product detail view
- **Widgets**:
  - `ProductCard` - Grid view product card
  - `ProductListItem` - **NEW** - List view product item
  - `ProductFilterBottomSheet` - Filter and sort options
  - `ProductDetailShimmer` - Loading state for product details

## New Fish Sauce Products Page

### Features
The `FishSauceProductsPage` is a new implementation that matches the exact Figma design:

#### Header Section
- **MGF Logo**: Brand logo with green background
- **Brand Text**: "MGF HEALTHY CHOICE" in Vietnamese
- **User Greeting**: "Xin chào, Nguyen Van A" with avatar
- **Design**: Matches Figma spacing and colors exactly

#### Search Functionality
- **Filter Button**: Green circular button with tune icon
- **Search Bar**: Rounded white container with search icon
- **Placeholder**: "Tìm kiếm..." in Vietnamese
- **Integration**: Connects to ProductListBloc for search functionality

#### Product Listing
- **Category Title**: "NƯỚC MẮM NHĨ" (Fish Sauce Nhĩ)
- **Product Cards**: Horizontal cards matching Figma design
- **Product Images**: 128x82 rounded containers
- **Product Info**: Name, original price, current price in VND
- **Add to Cart**: Brown button with Vietnamese text
- **Quantity Controls**: -/01/+ selector matching Figma

#### Order Banner
- **Background**: Dark green (#004917)
- **Text**: "Đặt hàng ngay hôm nay!" (Order now today!)
- **Subtext**: "Món quà cho những người bạn" (Gift for friends)
- **Icon**: Delivery scooter icon

#### Bottom Navigation
- **Cart Icon**: Shopping cart
- **Orders Icon**: Receipt icon
- **Home Icon**: Active green circular button
- **Notifications Icon**: Bell with red notification dot
- **Profile Icon**: Person icon

### Technical Implementation

#### State Management
```dart
MultiBlocProvider(
  providers: [
    BlocProvider<ProductsViewCubit>(create: (_) => ProductsViewCubit()),
    BlocProvider<ddd.ProductListBloc>(
      create: (_) => di.getIt<ddd.ProductListBloc>()
        ..add(const ddd.ProductListLoadRequested(page: 1, limit: 20)),
    ),
  ],
  // ...
)
```

#### Product Data Flow
1. **Load**: ProductListBloc loads products from repository
2. **Display**: Products displayed in Figma-matching cards
3. **Search**: Real-time search through ProductListBloc
4. **Add to Cart**: Integration with CartBloc for cart functionality
5. **Navigation**: GoRouter for page navigation

#### Vietnamese Localization
- All text in Vietnamese as per Figma design
- Price formatting in VND currency
- Vietnamese product names and descriptions
- Cultural context appropriate UI elements

## Usage

### Navigation
```dart
// Navigate to the new fish sauce products page
context.push('/fish-sauce-products');
```

### Adding Products to Cart
```dart
void _addToCart(ProductEntity product, String volume) {
  final cartBloc = context.read<CartBloc>();
  
  cartBloc.add(CartItemAdded(
    product: domainProduct,
    volume: volume,
    unitPrice: product.getPriceForVolume(volume),
    quantity: 1,
  ));
}
```

### Search Implementation
```dart
// Search products
context.read<ddd.ProductListBloc>().add(
  ddd.ProductListSearchRequested(searchQuery),
);
```

## Design Compliance

### Colors (Matching Figma)
- **Background**: #F5F5DC (Warm beige)
- **Primary Green**: #004917 (Dark green for banners)
- **Brand Green**: #4CAF50 (MGF brand color)
- **Price Red**: #EA3125 (Current price)
- **Text Dark**: #4E3620 (Product names)
- **Muted Text**: #989898 (Original prices)

### Typography
- **Product Names**: 11px, bold, #4E3620
- **Prices**: 11px, bold, #EA3125
- **Original Prices**: 8px, #989898
- **Vietnamese Text**: Appropriate font sizes for readability

### Spacing
- **Card Margins**: 22px between cards
- **Image Size**: 128x82px with 20px border radius
- **Button Heights**: 17px for add to cart buttons
- **Container Padding**: 14px internal padding

## Integration Points

### Cart System
- Integrates with existing CartBloc
- Converts ProductEntity to domain.Product
- Handles volume and pricing correctly
- Shows success feedback to users

### Navigation
- Uses GoRouter for navigation
- Maintains existing navigation patterns
- Integrates with bottom navigation
- Supports deep linking

### State Management
- Follows existing BLoC patterns
- Uses dependency injection
- Maintains clean separation of concerns
- Supports loading and error states

## Future Enhancements

### Planned Features
1. **Real-time Search**: Debounced search input
2. **Infinite Scroll**: Pagination for large product lists
3. **Favorites**: Heart icon for favorite products
4. **Filters**: Advanced filtering options
5. **Sorting**: Multiple sort options
6. **Animations**: Smooth transitions and micro-interactions

### Performance Optimizations
1. **Image Caching**: Efficient image loading and caching
2. **Lazy Loading**: Load images as they come into view
3. **State Persistence**: Maintain state across navigation
4. **Memory Management**: Proper disposal of controllers and listeners

## Testing

### Unit Tests
- BLoC state management tests
- Entity and use case tests
- Repository implementation tests

### Widget Tests
- Product card rendering tests
- Search functionality tests
- Add to cart interaction tests

### Integration Tests
- End-to-end user flows
- Navigation testing
- State persistence testing

## Code Quality

### Standards Compliance
- Follows Flutter coding standards
- Zero-warning policy enforced
- Proper error handling
- Comprehensive documentation

### Performance
- Efficient widget rebuilding
- Proper use of const constructors
- Optimized image loading
- Memory leak prevention

This implementation provides a solid foundation for the Vietnamese Fish Sauce product listing while maintaining code quality and architectural consistency.
