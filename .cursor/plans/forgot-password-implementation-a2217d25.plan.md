<!-- a2217d25-ff4d-45a7-8d38-0bd8fdefd2e8 acc4cc02-def1-48e2-8af9-47f0a659218a -->
# Forgot Password Screen Implementation Plan

## Overview

Implement a complete forgot password feature with MCP (Model Context Protocol) integration, following the existing Clean Architecture pattern in `lib/features/auth/`.

## Implementation Steps

### 1. MCP Integration Layer

**Location**: `lib/core/network/`

- Create `mcp_client.dart` - MCP service using Dio for HTTP requests
- Create `mcp_config.dart` - Configuration for MCP endpoints
- Add error handling and interceptors for MCP responses

### 2. Data Layer

**Location**: `lib/features/auth/data/`

- Update `auth_remote_datasource.dart`:
- Add `requestPasswordReset({required String phone})` method
- Add `verifyResetOtp({required String phone, required String otp})` method  
- Add `resetPassword({required String phone, required String newPassword})` method
- Use MCP client for API calls

### 3. Presentation Layer - State Management

**Location**: `lib/features/auth/presentation/cubit/`

- Create `forgot_password_cubit.dart`:
- States: `ForgotPasswordInitial`, `ForgotPasswordLoading`, `ForgotPasswordSuccess`, `ForgotPasswordError`
- Methods: `requestReset(String phone)`, `verifyOtp(String phone, String otp)`, `resetPassword(String phone, String newPassword)`

### 4. Presentation Layer - UI

**Location**: `lib/features/auth/presentation/views/`

- Create `forgot_password_page.dart`:
- Match existing login/register page design pattern
- Vietnamese text: "QUÊN MẬT KHẨU" title
- Phone number input field
- "GỬI MÃ OTP" button
- Link back to login page
- Use existing auth assets (background, graphics from `AuthAssets`)
- Colors: `Color(0xFF935900)` for text, `Color(0xFFFF6200)` for button

### 5. Routing

**Location**: `lib/app/routes/app_router.dart`

- Add route: `/forgot-password` 
- Add to router configuration as public route (no auth required)
- Update login page to include "Quên mật khẩu?" link

### 6. Assets (if needed)

**Location**: `lib/core/constants/`

- Update `auth_assets.dart` if new assets are required
- Reuse existing login background/graphics

## Key Files to Modify/Create

### New Files

- `lib/core/network/mcp_client.dart`
- `lib/core/network/mcp_config.dart`  
- `lib/features/auth/presentation/cubit/forgot_password_cubit.dart`
- `lib/features/auth/presentation/views/forgot_password_page.dart`

### Modified Files

- `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- `lib/app/routes/app_router.dart`
- `lib/features/auth/presentation/views/login_page.dart` (add forgot password link)

## Design Patterns to Follow

- Clean Architecture (data/domain/presentation layers)
- BLoC/Cubit for state management
- Repository pattern for data access
- Vietnamese localization
- Existing color scheme and fonts (KoHo, Poppins)
- Zero-warning policy compliance

### To-dos

- [ ] Create MCP client and configuration for API integration using Dio
- [ ] Add forgot password methods to AuthRemoteDataSource with MCP calls
- [ ] Create ForgotPasswordCubit for state management
- [ ] Build ForgotPasswordPage UI matching existing auth design patterns
- [ ] Add forgot password route and link from login page
- [ ] Test forgot password flow and verify zero-warning compliance