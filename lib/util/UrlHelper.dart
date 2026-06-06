import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  /// 🌐 Open Website
  static Future<void> openUrl(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /// 📞 Phone Call

  /// 📞 Format number (+91 add if missing)
  static String formatPhone(String phone) {
    phone = phone.trim();

    if (phone.startsWith('+')) {
      return phone; // already has country code
    } else if (phone.startsWith('0')) {
      return "+91${phone.substring(1)}";
    } else {
      return "+91$phone";
    }
  }

  /// 📞 Call function
  static Future<void> call(String phoneNumber) async {
    final Uri uri = Uri.parse("tel:$phoneNumber");

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print("Dialer not supported");
      }
    } catch (e) {
      print("Call error: $e");
    }
  }

  /// 💬 WhatsApp
  static Future<void> whatsapp(
      String phoneNumber, {
        String message = "",
      }) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length != 10) {
      debugPrint('Invalid phone number');
      return;
    }

    final finalNumber = "91$cleaned";

    final Uri uri = Uri.parse(
      "https://wa.me/$finalNumber?text=${Uri.encodeComponent(message)}",
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('WhatsApp not installed or cannot launch');
      }
    } catch (e) {
      debugPrint('WhatsApp launch error: $e');
    }
  }

  static Future<void> shareOnWhatsApp(String message) async {
    final url =
    Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('WhatsApp not installed or cannot launch');
      }
    } catch (e) {
      debugPrint('WhatsApp launch error: $e');
    }
  }

  /// 📧 Email
  static Future<void> email(
      String emailAddress, {
        String subject = "",
        String body = "",
      }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query:
      "subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// 📍 Map with Lat/Long
  static Future<void> navigateToMap(
      double latitude,
      double longitude,
      ) async {
    final String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    final String appleUrl = "http://maps.apple.com/?daddr=$latitude,$longitude";

    final Uri uri = Platform.isIOS
        ? Uri.parse(appleUrl)
        : Uri.parse("geo:$latitude,$longitude?q=$latitude,$longitude");

    try {
      // Try native maps first
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // fallback to Google Maps web
        final fallbackUri = Uri.parse(googleUrl);

        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(
            fallbackUri,
            mode: LaunchMode.externalApplication,
          );
        }
      }
    } catch (e) {
      debugPrint("Map navigation error: $e");
    }
  }

  /// 📍 Map Search
  static Future<void> map(String query) async {
    final uri = Platform.isIOS
        ? Uri.parse("http://maps.apple.com/?q=${Uri.encodeComponent(query)}")
        : Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> share(String message) async {
    final cleanMessage = message.trim();

    Share.share(
      cleanMessage,
      subject: "InfyFind Business",
    );
  }
}
