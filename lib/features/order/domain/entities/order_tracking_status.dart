import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

enum OrderTrackingStatus {
  received,
  preparing,
  packaging,
  shipping,
  handover,
  delivered;

  String get subtitle {
    return switch (this) {
      received => AppStrings.orderReceivedSubtitle,
      preparing => AppStrings.orderPreparingSubtitle,
      packaging => AppStrings.orderPackagingSubtitle,
      shipping => AppStrings.orderShippingSubtitle,
      handover => AppStrings.orderHandoverSubtitle,
      delivered => AppStrings.orderDeliveredSubtitle,
    };
  }

  String get title {
    return switch (this) {
      received => AppStrings.orderReceivedTitle,
      preparing => AppStrings.orderPreparingTitle,
      packaging => AppStrings.orderPackagingTitle,
      shipping => AppStrings.orderShippingTitle,
      handover => AppStrings.orderHandoverTitle,
      delivered => AppStrings.orderDeliveredTitle,
    };
  }

  IconData get icon {
    return switch (this) {
      received => Icons.check_circle,
      preparing => Icons.schedule,
      packaging => Icons.inventory_2,
      shipping => Icons.local_shipping,
      handover => Icons.person,
      delivered => Icons.delivery_dining,
    };
  }
}
