# Customer Support Feature

## Overview

Customer support screen that provides users with access to various support options including contact information, FAQs, and information about MGF.

## Architecture

This feature follows a simplified Clean Architecture pattern as it only contains presentation layer components with static data.

```
lib/features/support/
└── presentation/
    └── views/
        └── customer_support_page.dart
```

## Components

### CustomerSupportPage
- **Location**: `lib/features/support/presentation/views/customer_support_page.dart`
- **Route**: `/customer-support`
- **Description**: Main customer support screen matching Figma design (node 1-897)

#### Features:
- **Introduction Section**: Title "Bạn cần hỗ trợ vấn đề gì?" with welcome message
- **Policy Options**: Four clickable white boxes with borders (Navigate to chat screens)
  - Chính sách đổi trả sản phẩm (Product return policy)
  - Chính sách giao hàng (Delivery policy)
  - Thông tin nước mắm MGF (MGF fish sauce information)
  - Thông tin về MGF (About MGF information)
- **Contact Section**: Three contact methods with icons
  - Trò chuyện với nhân viên tư vấn (Chat with consultant)
  - Hotline: 0123456789
  - Địa chỉ showroom MGF (Full address with location)

#### UI Components:
- Custom header "Hỗ trợ tư vấn MGF" using `CustomSupportHeader` widget
- Introduction section with title and description
- Clickable policy boxes in white with gray borders
- Contact items with circular icon borders
- Bottom navigation using `HomeBottomNavigation`

### SupportChatPage
- **Location**: `lib/features/support/presentation/views/support_chat_page.dart`
- **Route**: `/support-chat/:topic`
- **Description**: Chat-style support screens matching Figma designs (nodes 1-1092, 1-1124, 1-1024, 1-1058)

#### Features:
- **Chat Interface**: WhatsApp-like chat UI
- **Dynamic Content**: Different responses based on selected topic
- **Message Bubbles**: Green bubbles for user/system, white for responses
- **Input Field**: Text input with send button (SVG icon)
- **Same Header/Footer**: Consistent with main support page

#### Supported Topics:
1. **Trò chuyện với nhân viên tư vấn** - General consultant chat
2. **Thông tin về MGF** - About MGF with website link
3. **Chính sách giao hàng** - Delivery policy information
4. **Thông tin nước mắm MGF** - Fish sauce product details

#### UI Components:
- Chat bubbles with rounded corners (44px for user, 10px for responses)
- Green background (#004917) for user/greeting messages
- White background for system responses
- Text input with gray border (#8A8A8A)
- SVG send button (green circle with arrow)
- Divider line below title section

## Reusable Components

### CustomSupportHeader
- **Location**: `lib/shared/widgets/custom_support_header.dart`
- **Purpose**: Reusable header component for support and profile-related screens
- **Features**:
  - Back button with navigation
  - Centered title text
  - Profile avatar on the right
  - Configurable title text
  - Consistent styling with app design

#### Usage:
```dart
CustomSupportHeader(
  title: 'Hỗ trợ khách hàng',
  onBackPressed: () => context.pop(), // Optional
  showAvatar: true, // Optional, default: true
)
```

## Design System

### Colors
- Primary Red: `AppColors.cProfilePrimaryRed` (#900407)
- Text Gray: `AppColors.cProfileTextGray` (#8A8A8A)
- Border Gray: `AppColors.cProfileBorderGray` (#D9D9D9)
- Title Red: `AppColors.cProfileTitleRed` (#8E0306)

### Typography
- Font Family: Poppins
- Sizes: 9px-16px
- Weights: Regular (400), SemiBold (600), Bold (700)

### Spacing
- Horizontal padding: 42px for main content
- Border radius: 5px for containers
- Vertical spacing: 6px-20px between elements

## Navigation

### From Other Screens
The customer support page can be accessed from:
1. **Change Password Page**: Support section items
2. **Profile Page**: Support tiles in profile overview

### Implementation:
```dart
// Navigate to customer support main page
context.push('/customer-support');

// Navigate to specific support chat
context.push('/support-chat/${Uri.encodeComponent('Chính sách giao hàng')}');
```

### Navigation Flow:
```
Profile/Change Password
  ↓
Customer Support (Main)
  ↓ (Click policy box)
Support Chat (Topic-specific)
```

## Static Data

All support content is hardcoded exactly as per Figma design:
- **Title**: "Bạn cần hỗ trợ vấn đề gì?"
- **Description**: "Cảm ơn Quý khách đã quan tâm đến sản phẩm của MGF..."
- **Policy Options**: 4 boxes for policies and information
- **Contact Methods**:
  - Chat with consultant ("Trò chuyện với nhân viên tư vấn")
  - Hotline: 0123456789
  - Address: 93/42 Hoàng Hoa Thám, Phường 6, Bình Thạnh, TP. Hồ Chí Minh, Việt Nam

## Future Enhancements

Potential improvements for future versions:
1. ✅ ~~Make policy boxes tappable~~ (DONE - navigates to chat)
2. Integration with live chat system for real-time consultant
3. Functional send button with message history
4. Real phone dialer integration for hotline
5. Map integration for showroom address
6. Dynamic policy content from CMS/API
7. Support ticket system and persistent chat history
8. File/image sharing in chat
9. Read receipts and typing indicators
10. Push notifications for support responses

## DRY Principles Applied

- ✅ Reused `CustomSupportHeader` widget (new reusable component)
- ✅ Reused `HomeBottomNavigation` component
- ✅ Reused `FigmaAssets.background` for consistent UI
- ✅ Reused color constants from `AppColors`
- ✅ Reused Poppins font styling throughout
- ✅ Consistent layout pattern from profile pages

## Testing

Manual testing checklist:
- [ ] Page loads with correct background and header
- [ ] Profile card displays user name from AuthBloc
- [ ] All support option items are tappable
- [ ] Dialogs display correct information
- [ ] Back button navigates to previous screen
- [ ] Bottom navigation works correctly
- [ ] Responsive layout on different screen sizes

## Related Files

**Pages:**
- Main support page: `lib/features/support/presentation/views/customer_support_page.dart`
- Chat interface: `lib/features/support/presentation/views/support_chat_page.dart`

**Routing:**
- Route configuration: `lib/app/routes/app_router.dart`

**Navigation Sources:**
- Change password page: `lib/features/profile/presentation/views/change_password_page.dart`
- Profile support tiles: `lib/features/profile/presentation/widgets/profile_overview.dart`

**Shared Components:**
- Custom header: `lib/shared/widgets/custom_support_header.dart`
- Bottom navigation: `lib/features/home/presentation/widgets/bottom_navigation.dart`

**Assets:**
- Send button SVG: `assets/figma_exports/92f898c6afa4e605739c3f99284189c2ca21d489.svg`

---

**Figma Design Reference**: Node ID 1-897
**Created**: 2025
**Last Updated**: 2025

