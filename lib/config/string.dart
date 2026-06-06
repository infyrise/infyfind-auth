import 'package:flutter/foundation.dart';

class ApiConstants {

  static const String _mainBase = 'https://infyfind.com';

  static const String _prodHost = 'www.infyhire.com';
  static const String _localHost = '127.0.0.1:8080';

  static const String _prodBase = 'https://api.infyfind.com';
  static const String _localBase = 'http://127.0.0.1:8080';

  /// Host only
  static String get url {
    return kReleaseMode ? _prodHost : _localHost;
  }

  /// Full base URL
  static String get baseUrl {
    return kReleaseMode ? _prodBase :_localBase;
  }

  static String get mainUrl {
    return _mainBase;
  }
  static const String jobPath = '/jobs';
  static const String apiPath = '/api';
  static final String apiBaseUrl = '$baseUrl$apiPath';
  static final String apiStorageUrl = '$baseUrl/storage/';
}
