import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchHelper {
  static Future<void> callUs({required String number}) async {
    final cleanNumber = number.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse('tel:$cleanNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch phone dialer for $uri');
    }
  }

  static Future<void> emailUs({required String email}) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );

    launchUrl(emailLaunchUri);
  }

  static Future<void> launchInstagram({
    required String username,
  }) async {
    final Uri appUri = Uri.parse("instagram://user?username=$username");

    final Uri webUri = Uri.parse("https://www.instagram.com/$username");

    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchInBrowser(Uri url) async {
    try {
      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        showToast(message: 'Could not launch browser');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      showToast(message: 'Error opening page');
    }
  }

  static Future<void> launchWhatsApp({
    required String phone,
    String message = "",
  }) async {
    final whatsappNumber = phone.replaceAll(RegExp(r'[^\d]'), '');
    // Ensure it has 91 prefix if it doesn't and is 10 digits
    String finalNumber = whatsappNumber;
    if (whatsappNumber.length == 10) {
      finalNumber = "91$whatsappNumber";
    }

    // WhatsApp app deep link - no spaces in phone parameter
    final Uri appUri = Uri.parse(
        "whatsapp://send?phone=$finalNumber&text=${Uri.encodeComponent(message)}");

    // WhatsApp Web fallback
    final Uri webUri = Uri.parse(
        "https://wa.me/$finalNumber?text=${Uri.encodeComponent(message)}");

    // Try app first
    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
    } else {
      // fallback to web
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchUpiViaSystemChooser(String qrString) async {
    final uri = Uri.parse(qrString);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      showToast(message: 'No UPI app found or cannot open', typeCheck: false);
    } else {}
  }

  static Future<void> openGoogleMap({
    required String lat,
    required String lng,
  }) async {
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
