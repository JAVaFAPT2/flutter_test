# UI Design Specifications - Vietnamese Fish Sauce App

## CRITICAL REQUIREMENT: 100% UI FIDELITY
All UI implementations MUST exactly match the provided screenshots in test_flutter folder.

## UI Design Requirements Based on Screenshots:

### Main Page (Trang chu.png)
- Vietnamese header with navigation
- Banner section with promotional images
- Product category sections:
  - "Vinh Thai" category
  - "Xuan Thinh Mau" category
- Grid layout for product displays
- Vietnamese text throughout

### Authentication Screens
- Login screen with Vietnamese text "Dang nhap"
- Registration screen "Dang ky"
- OTP verification "Gui ma OTP"
- Vietnamese form labels and placeholders

### Product Pages
- Product listing with Vietnamese filters
- Filter options for "VT" (Vinh Thai) and "XTM" (Xuan Thinh Mau)
- Product sizes: 250ml, 330ml, 500ml variants
- Vietnamese product descriptions

### Product Detail Screens
- "Vinh Thai" product detail
- "Xuan Thinh Mau 250ml" detail
- "Xuan Thinh Mau 330ml" detail  
- "Xuan Thinh Mau 500ml" detail
- Proper Vietnamese formatting

### Shopping Cart Screens
- Vietnamese cart interface "Gio hang"
- Edit cart functionality "Chinh sua gio hang"
- Selection features (checkbox selection)
- Delete functionality with Vietnamese confirmations
- Vietnamese quantity selectors

### Order Management Screens
- Payment process "Thanh toan" (3 steps)
- Order tracking "Theo doi don hang"
- Order status screens:
  - "Cho lay hang" (Wait to pickup)
  - "Cho xac nhan" (Wait for confirmation)
  - "Da giao" (Delivered)
  - "Da huy" (Cancelled)
  - "Dang giao" (In delivery)

### Profile & Support Screens
- User profile "Trang ca nhan"
- Customer service "Lien he Hotline"
- Chat function "Tro chuyen voi NV tu van"
- Feedback form "Y kien phan hoi"
- Change password "Doi mat khau"
- Delivery policy "Chinh sach giao hang"
- Return policy "Chinh sach doi tra"
- MGF company info "Thong tin MGF"
- Fish sauce info "Thong tin nuoc mam MGF"
- Notifications "Thong bao"

## Design System Requirements:

### Colors (Based on Screenshots)
- Primary brand colors matching Vietnamese fish sauce branding
- Consistent color scheme across all screens
- Proper contrast ratios for accessibility

### Typography
- Vietnamese font support
- Proper character rendering for Vietnamese diacritics
- Consistent text sizing throughout app

### Layout Patterns
- Vietnamese-first layout (left-to-right)
- Consistent spacing and margins
- Proper padding for Vietnamese text

### Vietnamese Localization Required:
- All UI text in Vietnamese
- Proper Vietnamese number formatting
- Currency formatting for Vietnamese Dong
- Date/time formatting for Vietnamese locale
- Vietnamese keyboard input support

## UI Implementation Requirements:

### Flutter Implementation Standards:
1. Use Vietnamese localization packages
2. Implement proper text directionality support
3. Use Material Design components with Vietnamese customization
4. Implement responsive design for various screen sizes
5. Ensure proper Vietnamese font rendering

### Screen-by-Screen Implementation:
1. Authentication Flow (5 screens)
2. Main Page with banners and categories (4 screens)
3. Product Catalog (4 screens)
4. Product Details (4 screens)
5. Shopping Cart (16 screens)
6. Order Management (7 screens)
7. Profile & Support (16 screens)

## UI Validation Checklist:
- [ ] All Vietnamese text properly displayed
- [ ] Screenshots match exactly to provided designs
- [ ] Vietnamese keyboard input works correctly
- [ ] Vietnamese currency formatting applied
- [ ] Vietnamese date/time formatting used
- [ ] Brand colors match screenshots exactly
- [ ] Layout matches pixel-perfect to designs
- [ ] Vietnamese fonts load and display correctly