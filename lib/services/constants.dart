// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlr/main.dart';
import 'package:vlr/services/route_helper.dart';
import 'package:vlr/services/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class PriceConverter {
  static convert(price) {
    String _cleanPrice = price.toString().replaceAll(',', '');

    return '₹ ${double.parse(_cleanPrice).toStringAsFixed(2)}';
  }

  static convertRound(price) {
    String _cleanPrice = price.toString().replaceAll(',', '');
    return '₹ ${double.parse(_cleanPrice).toInt()}';
  }

  static convertToNumberFormat(num price) {
    final format = NumberFormat("#,##,##,##0.00", "en_IN");
    return '₹ ${format.format(price)}';
  }
}

Widget sizedBoxHeight({required double height}) {
  return SizedBox(
    height: height,
  );
}

Widget sizedBoxWidth({required double width}) {
  return SizedBox(
    width: width,
  );
}

class Helper {
  final BuildContext context;
  Helper(this.context);

  Size get size => MediaQuery.sizeOf(context);
  TextTheme get textTheme => Theme.of(context).textTheme;
}

String capitalize(String? s) {
  if (s == null || s.isEmpty) return "";
  return s[0].toUpperCase() + s.substring(1);
}

void navigate({
  PageTransitionType type = PageTransitionType.fade,
  required BuildContext context,
  required Widget page,
  bool isReplace = false,
  bool isRemoveUntil = false,
  Duration duration = const Duration(milliseconds: 300),
}) {
  if (isReplace) {
    Navigator.of(context).pushReplacement(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
    );
  } else if (isRemoveUntil) {
    Navigator.of(context).pushAndRemoveUntil(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
      (route) => false,
    );
  } else {
    Navigator.of(context).push(
      getCustomRoute(
        child: page,
        type: type,
        duration: duration,
      ),
    );
  }
}

void pop(BuildContext context, {dynamic data}) {
  Navigator.pop(context, data);
}

enum ToastType {
  info(ToastificationType.info),
  warning(ToastificationType.warning),
  error(ToastificationType.error),
  success(ToastificationType.success);

  const ToastType(this.value);
  final ToastificationType value;
}

void showToast(
    {ToastType? toastType,
    required String message,
    String? description,
    ToastificationStyle? toastificationStyle,
    bool? typeCheck}) {
  toastification.show(
    alignment: Alignment.topLeft,
    type: toastType?.value ??
        ((typeCheck ?? false)
            ? ToastificationType.success
            : ToastificationType.error),
    title: Text(
      message,
      style:
          Helper(navigatorKey.currentContext!).textTheme.bodyMedium!.copyWith(
                color: black,
                fontSize: 14,
              ),
    ),
    description: description != null
        ? Text(description,
            style: Helper(navigatorKey.currentContext!)
                .textTheme
                .bodySmall!
                .copyWith(
                  color: black,
                ))
        : null,
    style: toastificationStyle ?? ToastificationStyle.minimal,
    icon: toastType == ToastType.success
        ? const Icon(Icons.check_circle_outline)
        : toastType == ToastType.error
            ? const Icon(Icons.error_outline)
            : toastType == ToastType.warning
                ? const Icon(Icons.warning_amber)
                : const Icon(Icons.info_outline),
    autoCloseDuration: const Duration(seconds: 2),
  );
}

String getStringFromList(List<dynamic>? data) {
  String str = data.toString();
  return data.toString().substring(1, str.length - 1);
}

class AppConstants {
  String get getBaseUrl => baseUrl;
  set setBaseUrl(String url) => baseUrl = url;

  //TODO: Change Base Url
  // static String baseUrl = 'https://app.feetrack.in/api/';
  // static String baseUrl = 'https://test.feetrack.in/api/';
  static String baseUrl = 'https://feetrackhrms.bestitcompanylucknow.com/api/';
  // static String baseUrl = 'http://192.168.1.22:8000/api/';
  static String baseImageUrl = 'https://app.feetrack.in/';
  // static String baseUrl = 'http://192.168.1.5:9000/'; ///USE FOR LOCAL
  // static String baseImageUrl = 'http://192.168.1.5:9000/';

  //TODO: Change Base Url

  static String appName = 'FeeTrack';

  static const String agoraAppId = 'c87b710048c049f59570bd1895b7e561';

  //* Auth
  static const String registrationUri = 'register/request-otp';
  static const String verifyMobileAndEmailOtp = 'register/verify';
  static const String resendVerifyMobileAndEmailOtp = 'register/resend-otp';
  static const String loginUri = 'login/request-otp';
  static const String loginOtpVerify = 'login/verify';
  static const String loginResendOtpVerify = 'login/resend-otp';
  static const String logoutUri = '';

  //* profile
  static const String getProfileUri = 'profile';
  static const String postLogout = 'logout';
  static const String putUpdateProfile = 'profile';
  static const String putUpdateFcmToken = 'fcm-token';
  static const String deleteAccountUri = 'account/destroy';

  //* Home
  static const String getCategories = 'categories';
  static const String getListing = 'listings';
  static const String getListingById = 'listings';
  static const String getBanner = 'app-banners';
  static String getProfileFacilities({required dynamic id}) =>
      "listings/$id/facilities";
  static String gymStaff({required dynamic id}) => "listings/$id/staff";
  static String gymStaffProfile({required dynamic id, required dynamic staffId}) =>
      "listings/$id/staff/$staffId";
  static String getProfileBranches({required int id}) =>
      "listings/$id/branches";

  //* Floors & Rooms
  static String getFloors({required dynamic id}) => "listings/$id/floors";
  static String getRooms({required dynamic id, required dynamic floorId}) =>
      "listings/$id/rooms?floor_id=$floorId";
  static String getRoomDetails({required dynamic id, required dynamic roomId}) =>
      "listings/$id/rooms/$roomId";

  //* select plan
  static String getProfileDurations({required dynamic id}) =>
      "listings/$id/durations";
  static String getProfilePlan({required dynamic id}) => "listings/$id/plans";

  //* reviews
  static String getReviews({required dynamic id}) => "listings/$id/reviews";
  static String putSubmitReviews({required dynamic id}) =>
      "listings/$id/reviews";

  //* Single category list
  static String categoryBanner({required dynamic id}) => "listings/$id/banners";

  //* Billing summary
  static const String billingPreview = "bookings/billing-preview";

  //* Subscription

  static const String postCreateBooking = 'bookings';

//!------ check this api is working or not
  static const String postCreateSubscription = 'subscriptions';
  static const String getSubscription = 'subscriptions';
  static const String getPaymentHistory = 'payments/history';
  static const String getWalletSummary = 'wallet/summary';
  static const String getReserveHistory = 'wallet/reserve-history';
  static const String getRechargeHistory = 'wallet/recharges';
  static const String getWithdrawalHistory = 'wallet/withdrawals';
  static const String getWalletHistory = 'wallet/history';
  static const String postWalletRecharge = 'wallet/recharge/request';
  static const String postWalletRechargeInitiate = 'wallet/recharge';
  static const String getRechargeConfig = 'wallet/recharge-config';
  static const String postWalletWithdrawal = 'wallet/withdraw';

  //* Coupons
  static String getCouponsList({required dynamic id}) =>
      "coupons?listing_id=$id";
  static String postApplyCouponCode = "coupons/apply";

  //* Visits
  static const String visitsUrl = 'visits';
  static String getVisitDetailUrl(String id) => 'visits/$id';

  static String downloadReceipt({required String type, required String id}) =>
      'invoice/$type/$id/download';

  //* Dashboard
  static const String recentTransactionsUri = 'transactions';

  //* KYC
  static const String kycUri = 'kyc';

  //* Notification
  static const String notificationUri = 'notifications';

  //* Attendance
  static const String punchInUri = 'attendance/punch-in';
  static const String punchOutUri = 'attendance/punch-out';
  static const String todayAttendanceUri = 'attendance/today';
  static const String attendanceHistoryUri = 'attendance';

  //
  static const double horizontalPadding = 16;
  static const double verticalPadding = 20;
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
      horizontal: AppConstants.horizontalPadding,
      vertical: AppConstants.verticalPadding);

  // Shared Key
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String razorpayKey = 'razorpay_key';
  static const String recentOrders = 'recent_orders';
  static const String isUser = 'is_user';
  static const String fcmToken = 'fcmToken';
}
