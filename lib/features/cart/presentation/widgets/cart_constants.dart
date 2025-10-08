import 'package:flutter/material.dart';

/// Constants for cart UI components
class CartConstants {
  // Colors
  static const Color primaryRed = Color(0xFFC80000);
  static const Color darkGreen = Color(0xFF004917);
  static const Color maroon = Color(0xFF900407);
  static const Color orange = Color(0xFFFF6B00);
  static const Color brown = Color(0xFF8B4513);
  static const Color textBrown = Color(0xFF4E3620);
  static const Color priceRed = Color(0xFFEA3125);
  static const Color greyText = Color(0xFF989898);

  // Dimensions
  static const double cardBorderRadius = 15.0;
  static const double imageBorderRadius = 20.0;
  static const double productImageWidth = 128.0;
  static const double productImageHeight = 82.0;
  static const double quantityControlHeight = 17.0;
  static const double quantityControlWidth = 60.0;

  // Text styles
  static const TextStyle productNameStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: textBrown,
  );

  static const TextStyle priceInfoStyle = TextStyle(
    fontSize: 8,
    color: greyText,
  );

  static const TextStyle currentPriceStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: priceRed,
  );

  static const TextStyle quantityTextStyle = TextStyle(
    fontSize: 8,
    color: Colors.black,
  );

  static const TextStyle subtotalStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: priceRed,
  );

  // Vietnamese strings
  static const String editCart = 'Chỉnh sửa giỏ hàng';
  static const String exitEditCart = 'X Chỉnh sửa giỏ hàng';
  static const String selectAll = 'Chọn tất cả';
  static const String delete = 'Xóa';
  static const String totalPayment = 'TỔNG THANH TOÁN';
  static const String productCount = 'SỐ LƯỢNG SẢN PHẨM MUA:';
  static const String checkout = 'THANH TOÁN';
  static const String deleteSelectedTitle = 'Xóa sản phẩm đã chọn';
  static const String cancel = 'Hủy';
}



