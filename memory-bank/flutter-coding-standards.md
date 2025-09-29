# Flutter Coding Standards - Zero Warning Policy

## CRITICAL: Zero Warning Policy
- **ZERO TOLERANCE** for dart analyze warnings
- **ZERO TOLERANCE** for flutter doctor issues
- **AUTOMATED ENFORCEMENT** through CI/CD pipeline
- **QUALITY GATES** blocking commits with warnings

## Active Flutter Coding Rules

### 1. Code Analysis Enforcement
```yaml
# analysis_options.yaml (REQUIRED)
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false
  errors:
    # CRITICAL ERRORS - BLOCK WORKFLOW
    invalid_annotation_target: error
    todo: error
    deprecated_member_use: error
    missing_required_param: error
    wrong_number_of_parameters_for_override: error
    missing_return: error
    
    # PERFORMANCE ERRORS
    avoid_function_literals_in_foreach_calls: error
    avoid_web_libraries_in_flutter: error
    avoid_slow_async_io: error
    prefer_typing_uninitialized_variables: error
    
    # CODE QUALITY ERRORS  
    avoid_print: error
    avoid_unnecessary_type_casts: error
    avoid_redundant_argument_values: error
    avoid_void_async: error
    
linter:
  rules:
    # ENFORCED CODING STANDARDS
    always_declare_return_types: true
    avoid_dynamic_calls: true
    avoid_print: true
    avoid_unused_constructor_parameters: true
    prefer_const_constructors: true
    prefer_const_declarations: true
    prefer_const_literals_to_create_immutables: true
    prefer_final_fields: true
    prefer_final_locals: true
    prefer_single_quotes: true
    sort_constructors_first: true
    sort_pub_dependencies: true
    sort_unnamed_constructors_first: true
```

### 2. Pre-commit Hooks (REQUIRED)
```bash
#!/bin/bash
# pre-commit hook

echo "Running Flutter Zero-Warning Checks..."

# Format check
dart format --set-exit-if-changed .
if [ $? -ne 0 ]; then
  echo "ERROR: Code not formatted. Run 'dart format .'"
  exit 1
fi

# Analyze check
flutter analyze --fatal-infos
if [ $? -ne 0 ]; then
  echo "ERROR: Analysis found warnings/errors"
  exit 1
fi

# Doctor check
flutter doctor
if [ $? -ne 0 ]; then
  echo "ERROR: Flutter doctor found issues"
  exit 1
fi

echo "Zero-Warning Policy: PASSED"
```

### 3. Development Environment Setup
```bash
# Setup script
flutter config --enable-web
flutter config --enable-desktop

# Install hooks
cp pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# IDE Configuration
echo "Configure your IDE to run 'flutter analyze --fatal-infos' before save"
```

### 4. Auto-fix Commands
```bash
# Auto-fix common issues
dart fix --apply

# Auto-format
dart format .

# Clean build with analysis
flutter clean
flutter pub get
flutter analyze --fatal-infos
```

### 5. Quality Gates Checklist
- [ ] `dart analyze` returns 0 errors, 0 warnings
- [ ] `dart format` shows no differences
- [ ] `flutter doctor` shows no issues
- [ ] No TODO comments in code
- [ ] All deprecated APIs replaced
- [ ] All print() statements removed
- [ ] All const constructors used where possible
- [ ] All unused imports removed
- [ ] All variables properly typed (no dynamic)

### 6. Continuous Integration Enforcement
```yaml
# .github/workflows/flutter-ci.yml
name: Flutter Zero-Warning CI

on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.24.x'
    - run: flutter pub get
    - run: flutter analyze --fatal-infos
    - run: dart format --set-exit-if-changed .
    - run: flutter doctor
```

### 7. Warning Categories and Fixes
| Category | Auto-fix Command | Manual Action |
|----------|-----------------|----------------|
| Format Issues | `dart format .` | N/A |
| Deprecated APIs | `dart fix --apply` | Replace with modern APIs |
| Unused Code | `dart fix --apply` | Remove unused imports/variables |
| Type Issues | Manual | Add proper type annotations |
| Lint Rules | `dart fix --apply` | Follow linting suggestions |

### 8. Emergency Override Process
```bash
# ONLY use in emergencies with approval
git commit --no-verify -m "EMERGENCY: [Reason] - Override zero-warning policy"

# MUST create follow-up issue
echo "Create GitHub issue to fix warnings within 24 hours"
```

## ENFORCEMENT LEVEL: MAXIMUM
This policy must be applied to ALL Flutter development in this project.
No exceptions without explicit approval and documented justification.