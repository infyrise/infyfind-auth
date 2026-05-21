import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/device_info_model.dart';


class DeviceInfoController {
  static DeviceInfoModel? deviceInfo;

  /// Call this method on app start
  static Future<void> initialize() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    // Device info variables
    String deviceName = '';
    String deviceId = '';
    String os = '';
    String browser = 'App';

    // Android
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;

      String brand = androidInfo.brand;
      String manufacturer = androidInfo.manufacturer;
      String model = androidInfo.model;
      String device = androidInfo.device ?? 'Unknown';
      String board = androidInfo.board ?? 'Unknown';
      String hardware = androidInfo.hardware ?? 'Unknown';
      String product = androidInfo.product ?? 'Unknown';
      String fingerprint = androidInfo.fingerprint ?? 'Unknown';
      String androidVersion = androidInfo.version.release ?? 'Unknown';
      String sdkInt = androidInfo.version.sdkInt.toString();

      deviceName =
          '$brand $manufacturer $model (device: $device, board: $board, hardware: $hardware, product: $product, fingerprint: $fingerprint, Android $androidVersion, SDK $sdkInt)';

      deviceId = androidInfo.id ?? '';
      os = 'Android $androidVersion (SDK $sdkInt)';
    }
    // iOS
    else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;

      String name = iosInfo.name ?? 'iOS Device';
      String model = iosInfo.model ?? 'Unknown';
      String localizedModel = iosInfo.localizedModel ?? '';
      String utsnameMachine = iosInfo.utsname.machine ?? '';
      String systemName = iosInfo.systemName ?? 'iOS';
      String systemVersion = iosInfo.systemVersion ?? '';

      deviceName =
          '$name $model ($localizedModel, $utsnameMachine), $systemName $systemVersion';

      deviceId = iosInfo.identifierForVendor ?? '';
      os = '$systemName $systemVersion';
    }

    // App Version
    final packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    // Location (optional)
    String location = '';
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      location = '${position.latitude},${position.longitude}';
    } catch (_) {
      location = 'Unknown';
    }

    // Save globally
    deviceInfo = DeviceInfoModel(
      deviceName: deviceName,
      deviceId: deviceId,
      os: os,
      browser: browser,
      appVersion: appVersion,
      location: location,
    );
  }
}
