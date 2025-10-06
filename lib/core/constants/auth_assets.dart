/// Auth and intro screen assets
/// These are separate from main figma exports as they come from different Figma pages
class AuthAssets {
  AuthAssets._();

  // Base path for auth assets
  static const String _authBasePath = 'assets/begin_login_register';

  // Intro screen assets
  static const String backgroundIntro = '$_authBasePath/main/background.png';
  static const String productPack = '$_authBasePath/main/product.png';
  static const String logoMgf = '$_authBasePath/main/Logo MGF.png';

  // Login screen assets
  static const String backgroundLogin = 'assets/login/background.png';
  static const String topRightLogin = 'assets/login/topRight.png';
  // Use unified Figma-exported asset for the green graphic to match design
  static const String graphicGreenLogin =
      'assets/figma_exports/graphic_green.png';
  static const String backButtonLogin = 'assets/login/backButton.png';

  // Register screen assets
  static const String backgroundRegister = '$_authBasePath/register/Nền.png';
  static const String rightPicRegister = '$_authBasePath/register/rightpic.png';
  static const String leftButtonRegister =
      '$_authBasePath/register/leftbutton.png';
  static const String graphicGreenRegister =
      '$_authBasePath/register/graphicGreen.png';

  // SVG assets (for SmartAssetImage fallback)
  static const String svgBackgroundIntro = '$_authBasePath/main/Nền.svg';
  static const String svgWebIcon = '$_authBasePath/main/Web.svg';
  static const String svgInfoCircle = '$_authBasePath/main/I.svg';
  static const String svgBackgroundLogin = '$_authBasePath/login/Nền.svg';
  static const String svgLoginTopRight =
      '$_authBasePath/login/Hình góc phải.svg';
  static const String svgLoginAccent = '$_authBasePath/login/Graphic xanh.svg';
  static const String svgBackButton = '$_authBasePath/login/Back button.svg';
  static const String svgBackgroundRegister = '$_authBasePath/register/Nền.svg';
  static const String svgRegisterTopRight =
      '$_authBasePath/register/Hình góc phải.svg';
  static const String svgRegisterAccent =
      '$_authBasePath/register/Graphic xanh.svg';
  static const String svgRegisterBackButton =
      '$_authBasePath/register/Back button.svg';
  static const String svgRegisterCheckIcon =
      '$_authBasePath/register/Check icon.svg';
  static const String svgRegisterFrame = ''; // Not yet provided - placeholder
}
