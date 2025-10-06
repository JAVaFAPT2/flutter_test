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

  // Menu icons
  static const String bellMenu = '$_basePath/bell_menu.png';
  static const String homeMenu = '$_basePath/home_menu.png';
  static const String profileMenu = '$_basePath/profile_menu.png';
  static const String menuBox = '$_basePath/menu_box.png';

  // Small icons
  static const String smallIcon1 = '$_basePath/small_icon_1.png';
  static const String smallIcon2 = '$_basePath/small_icon_2.png';
  static const String smallIcon3 = '$_basePath/small_icon_3.png';
}
