/// Vietnamese localization strings for fish sauce e-commerce app
abstract class AppStrings {
  // Authentication
  static const String login = 'Đăng nhập';
  static const String register = 'Đăng ký';
  static const String logout = 'Đăng xuất';
  static const String forgotPassword = 'Quên mật khẩu';
  static const String resetPassword = 'Đặt lại mật khẩu';
  static const String enterPhoneNumber = 'Nhập số điện thoại';
  static const String enterPassword = 'Nhập mật khẩu';
  static const String confirmPassword = 'Xác nhận mật khẩu';
  static const String enterOTP = 'Nhập mã OTP';
  static const String sendOTP = 'Gửi mã OTP';
  static const String verifyOTP = 'Xác minh mã OTP';

  // Navigation
  static const String home = 'Trang chủ';
  static const String products = 'Sản phẩm';
  static const String categories = 'Danh mục';
  static const String cart = 'Giỏ hàng';
  static const String orders = 'Đơn hàng';
  static const String profile = 'Cá nhân';
  static const String search = 'Tìm kiếm';
  static const String filters = 'Bộ lọc';
  static const String sort = 'Sắp xếp';

  // Products
  static const String productName = 'Tên sản phẩm';
  static const String productPrice = 'Giá';
  static const String productDescription = 'Mô tả';
  static const String productIngredients = 'Thành phần';
  static const String productOrigin = 'Xuất xứ';
  static const String productVolume = 'Dung tích';
  static const String productBrand = 'Thương hiệu';
  static const String productRating = 'Đánh giá';
  static const String addToCart = 'Thêm vào giỏ';
  static const String addToFavorites = 'Yêu thích';
  static const String removeFromFavorites = 'Bỏ yêu thích';
  static const String outOfStock = 'Hết hàng';
  static const String inStock = 'Còn hàng';

  // Cart
  static const String shoppingCart = 'Giỏ hàng';
  static const String emptyCart = 'Giỏ hàng trống';
  static const String totalPrice = 'Tổng tiền';
  static const String subtotal = 'Tạm tính';
  static const String shipping = 'Phí vận chuyển';
  static const String tax = 'Thuế';
  static const String checkout = 'Thanh toán';
  static const String continueShopping = 'Tiếp tục mua sắm';
  static const String clearCart = 'Xóa giỏ hàng';

  // Orders
  static const String orderHistory = 'Lịch sử đơn hàng';
  static const String orderDetails = 'Chi tiết đơn hàng';
  static const String orderNumber = 'Mã đơn hàng';
  static const String orderDate = 'Ngày đặt';
  static const String orderStatus = 'Trạng thái';
  static const String orderTotal = 'Tổng tiền';
  static const String trackOrder = 'Theo dõi đơn hàng';
  static const String cancelOrder = 'Hủy đơn hàng';
  static const String reorder = 'Đặt lại';

  // Order Status
  static const String pending = 'Chờ xác nhận';
  static const String confirmed = 'Đã xác nhận';
  static const String preparing = 'Đang chuẩn bị';
  static const String shippingStatus = 'Đang giao';
  static const String delivered = 'Đã giao';
  static const String cancelled = 'Đã hủy';
  static const String returned = 'Đã trả hàng';

  // Profile
  static const String myProfile = 'Thông tin cá nhân';
  static const String editProfile = 'Chỉnh sửa thông tin';
  static const String fullName = 'Họ và tên';
  static const String email = 'Email';
  static const String phoneNumber = 'Số điện thoại';
  static const String address = 'Địa chỉ';
  static const String changePassword = 'Đổi mật khẩu';
  static const String oldPassword = 'Mật khẩu cũ';
  static const String newPassword = 'Mật khẩu mới';
  static const String confirmNewPassword = 'Xác nhận mật khẩu mới';

  // Support
  static const String helpCenter = 'Trung tâm hỗ trợ';
  static const String contactUs = 'Liên hệ chúng tôi';
  static const String faq = 'Câu hỏi thường gặp';
  static const String aboutUs = 'Về chúng tôi';
  static const String termsOfService = 'Điều khoản dịch vụ';
  static const String privacyPolicy = 'Chính sách bảo mật';
  static const String returnPolicy = 'Chính sách đổi trả';

  // Messages
  static const String loading = 'Đang tải...';
  static const String noInternet = 'Không có kết nối internet';
  static const String serverError = 'Lỗi máy chủ';
  static const String unknownError = 'Lỗi không xác định';
  static const String success = 'Thành công';
  static const String error = 'Lỗi';
  static const String warning = 'Cảnh báo';
  static const String info = 'Thông tin';
  static const String retry = 'Thử lại';
  static const String cancel = 'Hủy';
  static const String confirm = 'Xác nhận';
  static const String yes = 'Có';
  static const String no = 'Không';
  static const String ok = 'OK';
  static const String save = 'Lưu';
  static const String edit = 'Chỉnh sửa';
  static const String delete = 'Xóa';
  static const String searchProducts = 'Tìm kiếm sản phẩm...';
  static const String noResults = 'Không tìm thấy kết quả';
  static const String tryAgain = 'Thử lại';

  // Validation Messages
  static const String requiredField = 'Trường này là bắt buộc';
  static const String invalidEmail = 'Email không hợp lệ';
  static const String invalidPhone = 'Số điện thoại không hợp lệ';
  static const String passwordTooShort = 'Mật khẩu quá ngắn';
  static const String passwordTooLong = 'Mật khẩu quá dài';
  static const String passwordsNotMatch = 'Mật khẩu không khớp';
  static const String invalidOTP = 'Mã OTP không hợp lệ';
  static const String otpExpired = 'Mã OTP đã hết hạn';

  // Success Messages
  static const String loginSuccess = 'Đăng nhập thành công';
  static const String registerSuccess = 'Đăng ký thành công';
  static const String passwordChanged = 'Đổi mật khẩu thành công';
  static const String profileUpdated = 'Cập nhật thông tin thành công';
  static const String orderPlaced = 'Đặt hàng thành công';
  static const String productAddedToCart = 'Đã thêm sản phẩm vào giỏ hàng';
  static const String productRemovedFromCart = 'Đã xóa sản phẩm khỏi giỏ hàng';

  // Error Messages
  static const String loginFailed = 'Đăng nhập thất bại';
  static const String registerFailed = 'Đăng ký thất bại';
  static const String networkError = 'Lỗi kết nối mạng';
  static const String sessionExpired = 'Phiên đăng nhập đã hết hạn';
  static const String invalidCredentials = 'Thông tin đăng nhập không đúng';
  static const String userNotFound = 'Không tìm thấy người dùng';
  static const String productNotFound = 'Không tìm thấy sản phẩm';
  static const String orderNotFound = 'Không tìm thấy đơn hàng';
}
