class DeviceInfoModel {
  final String deviceName;
  final String deviceId;
  final String os;
  final String browser;
  final String appVersion;
  final String location;

  DeviceInfoModel({
    required this.deviceName,
    required this.deviceId,
    required this.os,
    required this.browser,
    required this.appVersion,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "device_name": deviceName,
      "device_id": deviceId,
      "os": os,
      "browser": browser,
      "app_version": appVersion,
      "location": location,
    };
  }
}
