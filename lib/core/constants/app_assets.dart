/// Application assets organized by feature/module
/// Centralized asset management following DRY principles
class AppAssets {
  AppAssets._();

  // Base paths
  static const String _figmaBasePath = 'assets/figma_exports';
  static const String _authBasePath = 'assets/begin_login_register';
  static const String _loginBasePath = 'assets/login';

  // Order Tracking Assets
  static const String orderTrackingBackground =
      '$_figmaBasePath/order_tracking_background.png';
  static const String orderTrackingMap =
      '$_figmaBasePath/order_tracking_map.png';
  static const String orderTrackingTimeline =
      '$_figmaBasePath/order_tracking_timeline.svg';
  static const String orderTrackingBackButton =
      '$_figmaBasePath/order_tracking_back_button.png';
  static const String orderTrackingOrderIcon =
      '$_figmaBasePath/order_tracking_order_icon.png';
  static const String orderTrackingSupportIcon =
      '$_figmaBasePath/support_icon.png';

  // Navigation Assets
  static const String navHome = '$_figmaBasePath/home_icon.png';
  static const String navOrders = '$_figmaBasePath/orders_icon.png';
  static const String navNotifications =
      '$_figmaBasePath/notifications_icon.png';
  static const String navProfile = '$_figmaBasePath/profile_icon.png';
  static const String navCart = '$_figmaBasePath/cart_icon.png';

  // Product Assets
  static const String productXtm500ml = '$_figmaBasePath/product_xtm_500ml.png';
  static const String productVinhThai = '$_figmaBasePath/product_vinh_thai.png';
  static const String productBanner = '$_figmaBasePath/banner_product.png';

  // UI Assets
  static const String searchIcon = '$_figmaBasePath/search_icon.png';
  static const String arrowRight = '$_figmaBasePath/arrow_right_icon.png';
  static const String heartIcon = '$_figmaBasePath/heart_icon.png';
  static const String logoMgf = '$_figmaBasePath/logo.png';

  // Payment Assets
  static const String logoZaloPay = '$_figmaBasePath/logo_zalopay.png';
  static const String logoVnPay = '$_figmaBasePath/logo_vnpay.png';
  static const String logoMoMo = '$_figmaBasePath/logo_momo.png';

  // Profile (renamed from hashed files)
  static const String profileEditPencil =
      '$_figmaBasePath/edit_pencil_icon.png';
  static const String profileAvatar =
      '$_figmaBasePath/profile_avatar_figma.png';

  // Order status icons (renamed from hashed files)
  static const String orderStatusPending =
      '$_figmaBasePath/order_pending_icon.png';
  static const String orderStatusPickup =
      '$_figmaBasePath/order_pickup_icon.png';
  static const String orderStatusShipping =
      '$_figmaBasePath/order_shipping_icon.png';
  static const String orderStatusDelivered =
      '$_figmaBasePath/order_delivered_icon.png';
  static const String orderStatusCancelled =
      '$_figmaBasePath/order_cancelled_icon.png';

  // Profile action icons (renamed from hashed files)
  static const String profileLockRed = '$_figmaBasePath/lock_red_icon.png';
  static const String profileEmailEnvelope =
      '$_figmaBasePath/email_envelope_icon.png';
  static const String profileLogout = '$_figmaBasePath/logout_icon.png';

  // Additional detailed icons (renamed from hashed files)
  static const String mgfLogoDetailed = '$_figmaBasePath/mgf_logo_detailed.png';
  static const String homeIconDetailed =
      '$_figmaBasePath/home_icon_detailed.png';
  static const String notificationsIconDetailed =
      '$_figmaBasePath/notifications_icon_detailed.png';
  static const String profileIconDetailed =
      '$_figmaBasePath/profile_icon_detailed.png';
  static const String cartIconDetailed =
      '$_figmaBasePath/cart_icon_detailed.png';
  static const String searchIconDetailed =
      '$_figmaBasePath/search_icon_detailed.png';

  // SVG assets with readable names
  static const String homeButtonInner = '$_figmaBasePath/home_button_inner.svg';
  static const String cardBorder = '$_figmaBasePath/card_border.svg';
  static const String dividerLine = '$_figmaBasePath/divider_line.svg';
  static const String orderTrackingTimelineSvg =
      '$_figmaBasePath/order_tracking_timeline.svg';

  // Auth Assets
  static const String authBackgroundIntro =
      '$_authBasePath/main/background.png';
  static const String authProductPack = '$_authBasePath/main/product.png';
  static const String authLogoMgf = '$_authBasePath/main/Logo MGF.png';
  static const String authBackgroundLogin = '$_loginBasePath/background.png';
  static const String authTopRightLogin = '$_loginBasePath/topRight.png';
  static const String authGraphicGreen = '$_figmaBasePath/graphic_green.png';
  static const String authBackButtonLogin = '$_loginBasePath/backButton.png';
}
