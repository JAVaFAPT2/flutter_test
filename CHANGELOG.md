## v1.0.1

- Authentication
  - Updated `login_page.dart` to use GoRouter navigation and refined Vietnamese text and spacing.
  - Updated `otp_verification_page.dart` navigation to GoRouter and adjusted layout.
  - Minor navigation cleanup in `register_page.dart` (GoRouter back navigation).

- Main Page (Trang chủ)
  - Redesigned `home_page.dart`:
    - Added banner carousel with indicators.
    - Added category tiles for "Vĩnh Thái" and "Xuân Thịnh Mậu".
    - Added quick action grid (Sản phẩm, Giỏ hàng, Đơn hàng, Cá nhân).

- Localization
  - Enabled `flutter_localizations` delegates in `main.dart` and confirmed supported locales (vi_VN, en_US).

- Notes
  - Kept providers, routing, and domain logic intact.
  - Next: refine register screen and proceed module-by-module to match provided screenshots pixel-perfect.


