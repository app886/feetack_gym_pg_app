import 'dart:developer';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/services/extensions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> postUserRegister({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.registrationUri,
        "postUserRegister",
        data,
      );

  Future<Response> postVerifyMobileAndEmail({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.verifyMobileAndEmailOtp,
        "postVerifyMobileAndEmail",
        data,
      );

  Future<Response> postResendVerifyMobileAndEmail(
          {required FormData data}) async =>
      await apiClient.postData(
        AppConstants.resendVerifyMobileAndEmailOtp,
        "postResendVerifyMobileAndEmail",
        data,
      );

  Future<Response> postLogin({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.loginUri,
        "postLogin",
        data,
      );

  Future<Response> postLoginOtpVerify({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.loginOtpVerify,
        "postLoginOtpVerify",
        data,
      );

  Future<Response> postLoginResendOtpVerify({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.loginResendOtpVerify,
        "postLoginResendOtpVerify",
        data,
      );

  Future<Response> fetchProfile() async => await apiClient.getData(
        AppConstants.getProfileUri,
        "fetchProfile",
      );

  Future<Response> logout({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postLogout,
        "logout",
        data,
      );

  Future<Response> updateProfile({required FormData data}) async =>
      await apiClient.putData(
        AppConstants.putUpdateProfile,
        "updateProfile",
        data,
      );

  Future<Response> postProfileUpdate({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.putUpdateProfile,
        "postProfileUpdate",
        data,
      );

  Future<Response> updateFcmToken({required dynamic data}) async =>
      await apiClient.putData(
        AppConstants.putUpdateFcmToken,
        "updateFcmToken",
        data,
      );

  Future<Response> deleteAccount() async => await apiClient.deleteData(
        AppConstants.deleteAccountUri,
        "deleteAccount",
      );

  // Future<Response> verifyOtp({required String phone, required String otp}) async => await apiClient.postData(
  //       AppConstants.verifyOtp,
  //       {
  //         "phone": phone,
  //         "otp": otp,
  //       },
  //     );

  Future<bool> saveFCMToken({
    required String fcmToken,
  }) async {
    try {
      return await sharedPreferences.setString(AppConstants.fcmToken, fcmToken);
    } catch (e, st) {
      log('saveFCMToken error: $e\n$st');
      return false;
    }
  }

  String getFCMToken() {
    return sharedPreferences.getString(AppConstants.fcmToken) ?? "";
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<void> setUserToken(String token) async {
    apiClient.updateHeader(token);
    await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userId);
    sharedPreferences.remove(AppConstants.fcmToken);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  Future<String> getDeviceId() async {
    int count = 0;

    while (OneSignal.User.pushSubscription.id.isNotValid && count < 0) {
      await Future.delayed(const Duration(seconds: 1));
      count++;

      log(count.toString(), name: 'DeviceId Wait Count');
      log('${OneSignal.User.pushSubscription.id}', name: "12345678");
      log('${OneSignal.User.pushSubscription.token}', name: "12345678");
    }

    if (OneSignal.User.pushSubscription.id.isValid) {
      return OneSignal.User.pushSubscription.id!;
    } else {
      return '12345678';
    }
  }
}
