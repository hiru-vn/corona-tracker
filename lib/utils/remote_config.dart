import 'package:firebase_remote_config/firebase_remote_config.dart';

// RemoteConfig has appropriated default values for int, String, double.
class AppRemoteConfig {
  static final _instance = AppRemoteConfig._();
  static AppRemoteConfig get instance => _instance;

  String _host;

  String get host => _host;

  Future<void> init() async {
    Map<String, RemoteConfigValue> map;
    RemoteConfigValue map1;

    try {
      final onValue = await RemoteConfig.instance;
      await onValue.fetch(expiration: Duration(seconds: 0));
      await onValue.activateFetched();
      map = onValue.getAll();
    } catch (_) {}

    if (map != null) {
      map1 = map['host'];
    }
    _host = _applyString(map1, 'http://10.0.2.2:3000');
  }

  String _applyString(RemoteConfigValue value, String defaultValue) {
    try {
      if (value != null) {
        return value.asString();
      }
    } catch (_) {
      return defaultValue;
    }
    return defaultValue;
  }

  AppRemoteConfig._();
}
