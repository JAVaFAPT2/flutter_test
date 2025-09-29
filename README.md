# Nước Mắm MGF - Vietnamese Fish Sauce E-commerce App

A comprehensive Vietnamese fish sauce e-commerce mobile application built with Flutter, following Clean Architecture principles and implementing a strict zero-warning policy.

## 🏗️ Architecture

### Clean Architecture Implementation
- **Domain Layer**: Business logic, entities, use cases, and repository interfaces
- **Data Layer**: Repository implementations, data sources, and models
- **Presentation Layer**: UI, state management, and navigation
- **Core Layer**: Constants, utilities, error handling, and dependency injection

### Key Features
- **Vietnamese Localization**: Complete Vietnamese interface and localization
- **Zero-Warning Policy**: Strict code quality enforcement with automated checks
- **Performance Optimized**: Lazy loading, caching, and efficient state management
- **Professional UI/UX**: Modern Material Design with Vietnamese fish sauce branding

## 📱 Features

### Phase 1: Infrastructure ✅
- Flutter project setup with Clean Architecture
- Zero-warning policy implementation
- Comprehensive linting and formatting
- Development environment setup

### Phase 2: Authentication ✅
- User login with phone/password
- User registration with validation
- Secure token management
- Vietnamese authentication interface

### Phase 3: Product Catalog ✅
- Product listing with grid/list views
- Advanced search and filtering
- Product categories and brands
- Vietnamese product showcase

### Phase 4: Product Details & Shopping Cart ✅
- Detailed product view with image gallery
- Product specifications and reviews
- Shopping cart with quantity management
- Vietnamese product information

### Phase 5: Checkout & Order Management ✅
- Complete checkout process
- Vietnamese address management
- Multiple payment methods
- Order confirmation and tracking

### Phase 6: User Profile & Settings ✅
- User profile management
- Order history with filtering
- App settings and preferences
- Vietnamese user interface

### Phase 7: Final Polish & Performance 🚧
- Performance optimizations
- Enhanced error handling
- Testing and quality assurance
- Deployment preparation

## 🛠️ Technology Stack

### Core Technologies
- **Flutter 3.24+**: Cross-platform mobile development
- **Dart**: Modern programming language
- **Provider**: State management
- **Go Router**: Navigation and routing
- **Dio**: HTTP client for API calls

### State Management
- **Provider** with ChangeNotifier for reactive state management
- **Clean Architecture** with domain-driven design
- **Repository Pattern** for data access abstraction

### UI/UX
- **Material Design 3** with Vietnamese localization
- **Cached Network Images** for optimized image loading
- **Responsive Design** for different screen sizes
- **Vietnamese Typography** and cultural considerations

### Development Tools
- **Flutter Lints** for code quality
- **Dart Format** for consistent formatting
- **Pre-commit Hooks** for automated quality gates
- **Zero-warning Policy** enforcement

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.24+
- Dart SDK 3.5+
- Android Studio or VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/vietnamese-fish-sauce-app.git
   cd vietnamese-fish-sauce-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Install pre-commit hooks**
   ```bash
   chmod +x pre-commit
   cp pre-commit .git/hooks/pre-commit
   ```

2. **Configure IDE**
   - Enable format on save
   - Set line length to 100 characters
   - Enable organize imports on save

3. **Run quality checks**
   ```bash
   ./dev.sh check
   ```

## 📁 Project Structure

```
lib/
├── src/
│   ├── core/                 # Core application logic
│   │   ├── constants/        # App constants and strings
│   │   ├── di/              # Dependency injection
│   │   ├── errors/          # Error handling
│   │   ├── theme/           # App theming
│   │   └── utils/           # Utility functions
│   ├── data/                # Data layer
│   │   ├── datasources/     # Data sources (API, local)
│   │   ├── models/         # Data models
│   │   └── repositories/   # Repository implementations
│   ├── domain/              # Domain layer
│   │   ├── entities/       # Business entities
│   │   ├── repositories/  # Repository interfaces
│   │   ├── use_cases/     # Business logic
│   │   └── value_objects/ # Domain value objects
│   └── presentation/        # Presentation layer
│       ├── pages/          # UI pages
│       ├── providers/      # State management
│       ├── routes/         # Navigation
│       └── widgets/        # Reusable widgets
└── main.dart               # App entry point
```

## 🎯 Features Overview

### Authentication
- Phone number and password login
- User registration with validation
- Secure token management
- Vietnamese authentication interface

### Product Catalog
- Vietnamese fish sauce product showcase
- Advanced search and filtering
- Category and brand browsing
- Product ratings and reviews

### Shopping Experience
- Product detail pages with specifications
- Shopping cart with quantity management
- Checkout process with Vietnamese addresses
- Order confirmation and tracking

### User Management
- User profile management
- Order history and tracking
- Account settings and preferences
- Vietnamese user interface

## 🔧 Development Guidelines

### Code Quality
- **Zero-warning policy**: All commits must pass quality gates
- **Clean Architecture**: Follow domain-driven design principles
- **Vietnamese Localization**: All user-facing text in Vietnamese
- **Performance**: Optimized for 60fps UI and fast API responses

### Naming Conventions
- **Vietnamese**: Use Vietnamese for user-facing strings
- **English**: Use English for code comments and internal names
- **CamelCase**: For class and method names
- **snake_case**: For file names

### Commit Guidelines
- Use conventional commit format
- Include phase information in commit messages
- Document major changes and features

## 📊 Performance Metrics

- **API Response Time**: < 200ms for normal loads
- **UI Performance**: 60fps smooth animations
- **Image Loading**: Optimized with caching
- **Memory Usage**: Efficient state management

## 🌍 Localization

The app supports Vietnamese as the primary language with:
- Complete Vietnamese UI strings
- Vietnamese date and number formatting
- Vietnamese currency symbols (₫)
- Vietnamese address formatting

## 🔒 Security

- Secure token storage with encryption
- Input validation on client and server
- Secure API communication
- User data protection

## 📱 Supported Platforms

- **Android**: API level 21+
- **iOS**: iOS 12+
- **Web**: Modern browsers (planned)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the coding standards
4. Run quality checks before committing
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Vietnamese fish sauce industry for inspiration
- Flutter community for excellent documentation
- Clean Architecture principles for scalable design
- Vietnamese language and culture for localization

---

**Nước Mắm MGF** - Bringing authentic Vietnamese fish sauce to your table through modern e-commerce technology! 🐟🍲
