import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // Authentication endpoints
  @POST('/auth/login')
  Future<HttpResponse<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> loginData,
  );

  @POST('/auth/register')
  Future<HttpResponse<Map<String, dynamic>>> register(
    @Body() Map<String, dynamic> registerData,
  );

  @POST('/auth/verify-otp')
  Future<HttpResponse<Map<String, dynamic>>> verifyOtp(
    @Body() Map<String, dynamic> otpData,
  );

  @POST('/auth/resend-otp')
  Future<HttpResponse<Map<String, dynamic>>> resendOtp(
    @Body() Map<String, dynamic> phoneData,
  );

  @POST('/auth/refresh-token')
  Future<HttpResponse<Map<String, dynamic>>> refreshToken(
    @Body() Map<String, dynamic> tokenData,
  );

  @POST('/auth/logout')
  Future<HttpResponse<Map<String, dynamic>>> logout();

  @POST('/auth/forgot-password')
  Future<HttpResponse<Map<String, dynamic>>> forgotPassword(
    @Body() Map<String, dynamic> emailData,
  );

  @POST('/auth/reset-password')
  Future<HttpResponse<Map<String, dynamic>>> resetPassword(
    @Body() Map<String, dynamic> resetData,
  );

  // User profile endpoints
  @GET('/user/profile')
  Future<HttpResponse<Map<String, dynamic>>> getUserProfile();

  @PUT('/user/profile')
  Future<HttpResponse<Map<String, dynamic>>> updateUserProfile(
    @Body() Map<String, dynamic> profileData,
  );

  @PUT('/user/change-password')
  Future<HttpResponse<Map<String, dynamic>>> changePassword(
    @Body() Map<String, dynamic> passwordData,
  );

  // Product endpoints
  @GET('/products')
  Future<HttpResponse<Map<String, dynamic>>> getProducts(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('category') String? category,
    @Query('brand') String? brand,
    @Query('search') String? search,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
  );

  @GET('/products/{id}')
  Future<HttpResponse<Map<String, dynamic>>> getProduct(
    @Path('id') String productId,
  );

  @GET('/products/featured')
  Future<HttpResponse<Map<String, dynamic>>> getFeaturedProducts();

  @GET('/products/categories')
  Future<HttpResponse<Map<String, dynamic>>> getCategories();

  @GET('/products/brands')
  Future<HttpResponse<Map<String, dynamic>>> getBrands();

  // Cart endpoints
  @GET('/cart')
  Future<HttpResponse<Map<String, dynamic>>> getCart();

  @POST('/cart/add')
  Future<HttpResponse<Map<String, dynamic>>> addToCart(
    @Body() Map<String, dynamic> cartItem,
  );

  @PUT('/cart/update/{itemId}')
  Future<HttpResponse<Map<String, dynamic>>> updateCartItem(
    @Path('itemId') String itemId,
    @Body() Map<String, dynamic> updateData,
  );

  @DELETE('/cart/remove/{itemId}')
  Future<HttpResponse<Map<String, dynamic>>> removeFromCart(
    @Path('itemId') String itemId,
  );

  @DELETE('/cart/clear')
  Future<HttpResponse<Map<String, dynamic>>> clearCart();

  // Order endpoints
  @GET('/orders')
  Future<HttpResponse<Map<String, dynamic>>> getOrders(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('status') String? status,
  );

  @GET('/orders/{id}')
  Future<HttpResponse<Map<String, dynamic>>> getOrder(
    @Path('id') String orderId,
  );

  @POST('/orders/create')
  Future<HttpResponse<Map<String, dynamic>>> createOrder(
    @Body() Map<String, dynamic> orderData,
  );

  @PUT('/orders/{id}/cancel')
  Future<HttpResponse<Map<String, dynamic>>> cancelOrder(
    @Path('id') String orderId,
  );

  @GET('/orders/{id}/tracking')
  Future<HttpResponse<Map<String, dynamic>>> getOrderTracking(
    @Path('id') String orderId,
  );

  // Payment endpoints
  @POST('/payment/create')
  Future<HttpResponse<Map<String, dynamic>>> createPayment(
    @Body() Map<String, dynamic> paymentData,
  );

  @GET('/payment/{id}/status')
  Future<HttpResponse<Map<String, dynamic>>> getPaymentStatus(
    @Path('id') String paymentId,
  );

  @POST('/payment/{id}/confirm')
  Future<HttpResponse<Map<String, dynamic>>> confirmPayment(
    @Path('id') String paymentId,
    @Body() Map<String, dynamic> confirmationData,
  );

  // Address endpoints
  @GET('/user/addresses')
  Future<HttpResponse<Map<String, dynamic>>> getAddresses();

  @POST('/user/addresses')
  Future<HttpResponse<Map<String, dynamic>>> addAddress(
    @Body() Map<String, dynamic> addressData,
  );

  @PUT('/user/addresses/{id}')
  Future<HttpResponse<Map<String, dynamic>>> updateAddress(
    @Path('id') String addressId,
    @Body() Map<String, dynamic> addressData,
  );

  @DELETE('/user/addresses/{id}')
  Future<HttpResponse<Map<String, dynamic>>> deleteAddress(
    @Path('id') String addressId,
  );

  // Notification endpoints
  @GET('/notifications')
  Future<HttpResponse<Map<String, dynamic>>> getNotifications(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @PUT('/notifications/{id}/read')
  Future<HttpResponse<Map<String, dynamic>>> markNotificationAsRead(
    @Path('id') String notificationId,
  );

  @DELETE('/notifications/{id}')
  Future<HttpResponse<Map<String, dynamic>>> deleteNotification(
    @Path('id') String notificationId,
  );

  @DELETE('/notifications/clear')
  Future<HttpResponse<Map<String, dynamic>>> clearAllNotifications();

  // Support endpoints
  @POST('/support/feedback')
  Future<HttpResponse<Map<String, dynamic>>> submitFeedback(
    @Body() Map<String, dynamic> feedbackData,
  );

  @POST('/support/contact')
  Future<HttpResponse<Map<String, dynamic>>> contactSupport(
    @Body() Map<String, dynamic> contactData,
  );

  @GET('/support/policies')
  Future<HttpResponse<Map<String, dynamic>>> getPolicies();

  @GET('/support/company-info')
  Future<HttpResponse<Map<String, dynamic>>> getCompanyInfo();

  // Banner endpoints
  @GET('/banners')
  Future<HttpResponse<Map<String, dynamic>>> getBanners();

  @GET('/banners/{id}')
  Future<HttpResponse<Map<String, dynamic>>> getBanner(
    @Path('id') String bannerId,
  );
}
