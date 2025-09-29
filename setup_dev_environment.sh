#!/bin/bash

# Development Environment Setup Script
# Vietnamese Fish Sauce E-commerce App - Zero Warning Policy

set -e

echo "🚀 Setting up development environment for Vietnamese Fish Sauce E-commerce App"
echo "=========================================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
print_status "Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed!"
    print_error "Please install Flutter from https://docs.flutter.dev/get-started/install"
    exit 1
fi

# Check Flutter version
FLUTTER_VERSION=$(flutter --version | head -1)
print_success "Flutter found: $FLUTTER_VERSION"

# Check Dart version
DART_VERSION=$(dart --version | head -1)
print_success "Dart found: $DART_VERSION"

# Configure Flutter for development
print_status "Configuring Flutter for development..."
flutter config --enable-web
flutter config --enable-desktop

# Install dependencies
print_status "Installing project dependencies..."
flutter pub get

# Run initial quality checks
print_status "Running initial quality checks..."

# Format code
print_status "Formatting code..."
dart format .

# Run analysis
print_status "Running static analysis..."
if ! flutter analyze --fatal-infos; then
    print_error "Static analysis found issues!"
    print_error "Please fix the warnings before proceeding."
    exit 1
fi

# Run doctor
print_status "Running Flutter doctor..."
flutter doctor

# Set up IDE configurations
print_status "Setting up IDE configurations..."

# VS Code settings
if command -v code &> /dev/null; then
    print_status "Configuring VS Code..."
    mkdir -p .vscode
    cat > .vscode/settings.json << EOF
{
    "dart.lineLength": 100,
    "dart.formatOnSave": true,
    "dart.enableCompletion": true,
    "dart.showTodos": false,
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.fixAll": true,
        "source.organizeImports": true
    },
    "files.associations": {
        "*.dart": "dart"
    }
}
EOF
    print_success "VS Code configuration created"
else
    print_warning "VS Code not found, skipping configuration"
fi

# Android Studio/IntelliJ settings
print_status "IDE configuration recommendations:"
echo "1. Enable 'Format on Save' in your IDE"
echo "2. Configure 'flutter analyze --fatal-infos' to run before save"
echo "3. Enable 'Organize imports on save'"
echo "4. Set line length to 100 characters"

# Create development shortcuts
print_status "Creating development shortcuts..."

# Create a development script
cat > dev.sh << 'EOF'
#!/bin/bash
# Development helper script

case "$1" in
    "format")
        echo "Formatting code..."
        dart format .
        ;;
    "analyze")
        echo "Running analysis..."
        flutter analyze --fatal-infos
        ;;
    "fix")
        echo "Auto-fixing issues..."
        dart fix --apply
        ;;
    "test")
        echo "Running tests..."
        flutter test
        ;;
    "clean")
        echo "Cleaning build..."
        flutter clean
        flutter pub get
        ;;
    "doctor")
        echo "Running doctor..."
        flutter doctor
        ;;
    "build")
        echo "Building for production..."
        flutter build apk --release
        ;;
    "check")
        echo "Running all quality checks..."
        dart format --set-exit-if-changed .
        flutter analyze --fatal-infos
        flutter doctor
        ;;
    *)
        echo "Usage: $0 {format|analyze|fix|test|clean|doctor|build|check}"
        exit 1
        ;;
esac
EOF

chmod +x dev.sh
print_success "Development script created: ./dev.sh"

# Environment variables
print_status "Setting up environment variables..."
if [ ! -f .env ]; then
    cat > .env.example << EOF
# Environment Configuration
# Copy this file to .env and update values

# API Configuration
API_BASE_URL=https://api.mgf-vietnam.com
API_TIMEOUT=30000

# App Configuration
APP_NAME=Nuoc Mam MGF
APP_VERSION=1.0.0

# Development
DEBUG=true
LOG_LEVEL=debug
EOF
    print_success "Environment template created: .env.example"
    print_warning "Copy .env.example to .env and configure your values"
fi

# Git hooks verification
print_status "Verifying git hooks..."
if [ -f .git/hooks/pre-commit ]; then
    print_success "Pre-commit hooks are installed"
else
    print_warning "Pre-commit hooks not found!"
    print_status "Installing pre-commit hooks..."
    cp pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    print_success "Pre-commit hooks installed"
fi

print_success "🎉 Development environment setup completed!"
echo ""
echo "🚀 Quick start commands:"
echo "  - Run 'flutter run' to start the app"
echo "  - Run './dev.sh check' to run all quality checks"
echo "  - Run './dev.sh format' to format code"
echo "  - Run './dev.sh analyze' to run static analysis"
echo ""
echo "📚 Remember: ZERO-WARNING POLICY is enforced!"
echo "   - All commits must pass quality gates"
echo "   - Fix any warnings before committing"
echo "   - Use './dev.sh check' before every commit"
echo ""
print_success "Happy coding! 🐟🍲"