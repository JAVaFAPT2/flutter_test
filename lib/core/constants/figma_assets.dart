/// Asset paths exported from Figma design
/// Consolidated and cleaned up - only includes assets actually used in the app
class FigmaAssets {
  // Private constructor to prevent instantiation
  FigmaAssets._();

  // Base path
  static const String _basePath = 'assets/figma_exports';

  // Background and UI elements
  static const String background = '$_basePath/home_header_bg.png';

  // Navigation icons
  static const String homeIcon = '$_basePath/home_icon.png';
  static const String ordersIcon = '$_basePath/orders_icon.png';
  static const String notificationsIcon = '$_basePath/notifications_icon.png';
  static const String profileIcon = '$_basePath/profile_icon.png';
  static const String cartIcon = '$_basePath/cart_icon.png';

  // Semantic aliases (preferred names)
  static const String navHome = homeIcon;
  static const String navOrders = ordersIcon;
  static const String navNotifications = notificationsIcon;
  static const String navProfile = profileIcon;
  static const String navCart = cartIcon;

  // Profile
  static const String avatarDefault = '$_basePath/avatar_default.png';
  static const String avatarPlaceholder = avatarDefault;

  // Products
  static const String productXtm500ml = '$_basePath/product_xtm_500ml.png';
  static const String productVinhThai = '$_basePath/product_vinh_thai.png';
  static const String productXtm500 = productXtm500ml;
  static const String productVinhThaiBottle = productVinhThai;

  // Search
  static const String searchIcon = '$_basePath/search_icon.png';
  static const String iconSearch = searchIcon;

  // UI Icons
  static const String arrowRight = '$_basePath/arrow_right_icon.png';
  static const String likeIcon = '$_basePath/heart_icon.png';
  static const String iconCaretRight = arrowRight;
  static const String iconHeart = likeIcon;

  // Gallery images
  static const String galleryImage1 = '$_basePath/gallery_image_1.png';
  static const String galleryImage2 = '$_basePath/gallery_image_2.png';
  static const String galleryImage3 = '$_basePath/gallery_image_3.png';
  static const String galleryA = galleryImage1;
  static const String galleryB = galleryImage2;
  static const String galleryC = galleryImage3;

  // Logo and branding
  static const String logoMgf = '$_basePath/logo.png';
  static const String mgfLogo = logoMgf;

  // Banner
  static const String bannerProduct = '$_basePath/banner_product.png';
  static const String bannerFeaturedProduct = bannerProduct;

  // Green graphic overlay used on auth/cart screens
  static const String graphicGreen = '$_basePath/graphic_green.png';

  // Checkout-specific assets exported directly from Figma (exact files)
  // Background image for checkout screens
  static const String checkoutBackground = '$_basePath/checkout_bg.png';
  // Back button image from Figma
  static const String checkoutBackButton =
      '$_basePath/checkout_back_button.png';

  // Menu icons
  static const String bellMenu = '$_basePath/bell_menu.png';
  static const String homeMenu = '$_basePath/home_menu.png';
  static const String profileMenu = '$_basePath/profile_menu.png';
  static const String menuBox = '$_basePath/menu_box.png';

  // Small icons
  static const String smallIcon1 = '$_basePath/small_icon_1.png';
  static const String smallIcon2 = '$_basePath/small_icon_2.png';
  static const String smallIcon3 = '$_basePath/small_icon_3.png';

  // Payment/badge logos from checkout Step 2 (exported)
  static const String logoZaloPay = '$_basePath/logo_zalopay.png';
  static const String logoVnPay = '$_basePath/logo_vnpay.png';
  static const String logoMoMo = '$_basePath/logo_momo.png';

  // Delivery address map placeholder
  static const String deliveryMapImage = '$_basePath/map_placeholder.png';

  // Order tracking page assets from Figma
  static const String orderTrackingBackground =
      '$_basePath/041af4dde44636a72296c18ab68cbfa6892579c5.png';
  static const String orderTrackingMap =
      '$_basePath/b9eee963f132f8d20b01f1d5504beea992f23086.png';
  static const String orderTrackingTimeline =
      '$_basePath/ae4dadeed7d15f376bf3e422c3b1fd63c12422e5.svg';
  static const String orderTrackingBackButton =
      '$_basePath/7cce197f9a05ae313b091174c27d09903dc71f0c.png';
  static const String orderTrackingOrderIcon =
      '$_basePath/cb30dbcbd7c639bd2a7a4a79d27823ad92510a03.png';
  static const String orderTrackingSupportIcon =
      '$_basePath/388db152a4ce67138f7e1fdc4a25af1b0a3d53d2.png';
}

// Legacy: FigmaProfileAssets moved to AppAssets for better organization
