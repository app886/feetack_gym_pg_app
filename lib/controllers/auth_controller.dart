import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/models/user_model.dart';
import 'package:vlr/firebase/get_fcm_token.dart';

import '../data/repositories/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool isLoading = false;
  bool _acceptTerms = true;

  bool get acceptTerms => _acceptTerms;

  File? profileImage;

  updateImages(File? image) {
    profileImage = image;
    update();
  }

  bool updateProfileLoading = false;

  TextEditingController fullNameController =
      TextEditingController(text: "Ajit");
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(text: "a@gmail.com");
  TextEditingController mobileNoController =
      TextEditingController(text: "8926600736");
  String? gender;
  List<String> genderList = ["Male", "Female", "Other"];

  //* Address TextEditingControllers

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  String? state;
  String? city;

  //* Register TextEditingControllers

  TextEditingController mobileOtpCodeController = TextEditingController();
  TextEditingController emailOtpCodeController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  Future<ResponseModel> registerUser() async {
    log('----------- registerUser Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "mobile": mobileNoController.text.trim(),
        "otp": "123456",
        "referral_code": referralCodeController.text.trim(),
      };

      Response response = await authRepo.postUserRegister(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == "success") {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "success registerUser ");
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT registerUser(): $e');
      responseModel = ResponseModel(false, "Error while registering user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyMobileAndEmail({
    required String mobileOtp,
    required String emailOtp,
  }) async {
    log('----------- verifyMobileAndEmail Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "mobile": mobileNoController.text.trim(),
        "email_otp": emailOtpCodeController.text.trim(),
        "mobile_otp": mobileOtpCodeController.text.trim(),
      };

      Response response = await authRepo.postVerifyMobileAndEmail(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == "success") {
        final responseData = response.body['data'];

        if (responseData != null && responseData['token'] != null) {
          await authRepo.setUserToken(responseData['token']);
          log("Saved token: ${responseData['token']}");
        }

        fullNameController.clear();
        mobileNoController.clear();
        emailController.clear();
        mobileOtpCodeController.clear();
        emailOtpCodeController.clear();

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success verifyMobileAndEmail ");
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT verifyMobileAndEmail(): $e');
      responseModel =
          ResponseModel(false, "Error while verifyMobileAndEmail  $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> resendVerifyMobileAndEmail() async {
    log('----------- resendVerifyMobileAndEmail Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "mobile": mobileNoController.text.trim(),
      };

      Response response = await authRepo.postResendVerifyMobileAndEmail(
        data: FormData(data),
      );

      // log("Raw Response: ${response.body}");

      if (response.body['status'] == "success") {
        final responseData = response.body['data'];

        if (responseData != null && responseData['token'] != null) {
          await authRepo.setUserToken(responseData['token']);
          log("Saved token: ${responseData['token']}");
        }

        mobileOtpCodeController.clear();
        emailOtpCodeController.clear();

        responseModel = ResponseModel(true,
            response.body['message'] ?? "success resendVerifyMobileAndEmail ");
      } else {
        String errorMessage = response.body['message'] ??
            "Error while resendVerifyMobileAndEmail";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT resendVerifyMobileAndEmail(): $e');
      responseModel =
          ResponseModel(false, "Error while resendVerifyMobileAndEmail  $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginUser({required bool isSMS}) async {
    log('----------- postLogin Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "mobile": mobileNoController.text.trim(),
        "channel": "whatsapp",
        // "channel": isSMS ? "sms" : "whatsapp",
      };

      Response response = await authRepo.postLogin(
        data: FormData(data),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        final body = response.body;

        if (body['status'] == "success") {
          responseModel = ResponseModel(
            true,
            body['message'] ?? "OTP sent successfully",
          );

          fullNameController.clear();
        } else {
          responseModel = ResponseModel(
            false,
            body['message'] ?? "Login failed",
          );
        }
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT loginUser(): $e');

      responseModel = ResponseModel(
        false,
        "Error while loginUser: $e",
      );
    }

    isLoading = false;
    update();

    return responseModel;
  }

  Future<ResponseModel> loginOtpVerify() async {
    log('----------- loginOtpVerify Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final data = {
        "mobile": mobileNoController.text.trim(),
        "otp": mobileOtpCodeController.text.trim(),
      };

      final Response response = await authRepo.postLoginOtpVerify(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == "success") {
        final responseData = response.body['data'];

        if (responseData != null && responseData['token'] != null) {
          await authRepo.setUserToken(responseData['token']);
          log("Saved token: ${responseData['token']}");
        }

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "Logged in successfully",
        );
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT loginOtpVerify(): $e');
      responseModel = ResponseModel(false, "Error while login otp verify $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postLoginResendOtpVerify({required bool isSMS}) async {
    log('----------- postLoginResendOtpVerify Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final data = {
        "mobile": mobileNoController.text.trim(),
        "channel": isSMS ? "sms" : "whatsapp",
      };

      final Response response = await authRepo.postLoginResendOtpVerify(
        data: FormData(data),
      );

      log("Raw Response: ${response.body}");

      if (response.body['status'] == "success") {
        final responseData = response.body['data'];

        if (responseData != null && responseData['token'] != null) {
          await authRepo.setUserToken(responseData['token']);
          log("Saved token: ${responseData['token']}");
        }

        responseModel = ResponseModel(
          true,
          response.body['message'] ?? "Resend opt in postLoginResendOtpVerify",
        );
      } else {
        String errorMessage = response.body['message'] ??
            "Error while postLoginResendOtpVerify user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT postLoginResendOtpVerify(): $e');
      responseModel = ResponseModel(
          false, "Error while postLoginResendOtpVerify otp verify $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  UserModel? userModel;

  Future<ResponseModel> fetchProfile() async {
    log('----------- fetchProfile Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.fetchProfile();

      if (response.body['status'] == "success") {
        userModel = UserModel.fromJson(response.body['data']);
        log("Profile fetched: ${userModel?.image}");

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success fetch fetchProfile ");
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT registerUser(): $e');
      responseModel =
          ResponseModel(false, "Error while fetch fetchProfile  $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> logout() async {
    log('----------- logout Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.logout(data: FormData({}));

      if (response.body['status'] == "success") {
        authRepo.clearSharedData();
        responseModel = ResponseModel(
            true, response.body['message'] ?? "success logout user ");
      } else {
        String errorMessage =
            response.body['message'] ?? "Error while registering user";

        if (response.body['errors'] != null &&
            response.body['errors']['mobile'] != null) {
          errorMessage = response.body['errors']['mobile'][0];
        }

        responseModel = ResponseModel(false, errorMessage);
      }
    } catch (e) {
      log('ERROR AT logout(): $e');
      responseModel = ResponseModel(false, "Error while logout user  $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteAccount() async {
    log('----------- deleteAccount Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.deleteAccount();

      if (response.body['status'] == "success") {
        authRepo.clearSharedData();
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Account deleted successfully");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while deleting account");
      }
    } catch (e) {
      log('ERROR AT deleteAccount(): $e');
      responseModel = ResponseModel(false, "Error while deleting account $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateProfile() async {
    log('----------- updateProfile Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final Map<String, dynamic> data = {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "mobile": mobileNoController.text.trim(),
        "_method": "PUT", // Method spoofing for multipart PUT
      };

      if (profileImage != null) {
        data['profile_image'] = MultipartFile(profileImage!,
            filename:
                'profile_${DateTime.now().millisecondsSinceEpoch}.jpg');
      }

      // Use POST instead of PUT because many servers (like Laravel) don't support
      // multipart/form-data in real PUT requests. We use _method=PUT above.
      Response response = await authRepo.postProfileUpdate(data: FormData(data));

      log("Update Profile Response: ${response.body}");

      if (response.body != null && response.body['status'] == "success") {
        profileImage = null; // Clear local image after success
        await fetchProfile();
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Profile updated successfully");
      } else {
        responseModel = ResponseModel(false,
            response.body?['message'] ?? "Error while updating profile");
      }
    } catch (e) {
      log('ERROR AT updateProfile(): $e');
      responseModel =
          ResponseModel(false, "Error while updating profile: $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateFcmToken() async {
    log('----------- updateFcmToken Called ----------');

    ResponseModel responseModel;

    try {
      String token = await NotificationServices().getDeviceToken();
      if (token.isNotEmpty) {
        await saveFMCToken(token);
      } else {
        token = authRepo.getFCMToken();
      }

      final data = {
        "fcm_token": token,
      };
      Response response = await authRepo.updateFcmToken(data: data);

      if (response.body['status'] == "success") {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "success updateFcmToken user ");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while updateFcmToken user ");
      }
    } catch (e) {
      log('ERROR AT updateFcmToken(): $e');
      responseModel =
          ResponseModel(false, "Error while updateFcmToken user  $e");
    }

    return responseModel;
  }

  Future<void> saveFMCToken(String fcmToken) async {
    final saveFCMToken = await authRepo.saveFCMToken(fcmToken: fcmToken);
    log('loginUser: saved FCM token: $saveFCMToken');
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }
}
