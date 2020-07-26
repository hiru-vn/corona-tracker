import 'package:firebase_remote_config/firebase_remote_config.dart';

// RemoteConfig has appropriated default values for int, String, double.
class AppRemoteConfig {
  static final _instance = AppRemoteConfig._();
  static AppRemoteConfig get instance => _instance;

  String _host = 'http://10.0.2.2:3000';
  String _mainImage = 'https://i.imgur.com/f9iZ0wB.png';

  String get host => _host;
  String get mainImage => _mainImage;

  Future<void> init() async {
    Map<String, RemoteConfigValue> map;
    RemoteConfigValue map1;
    RemoteConfigValue map2;

    try {
      final onValue = await RemoteConfig.instance;
      await onValue.fetch(expiration: Duration(seconds: 0));
      await onValue.activateFetched();
      map = onValue.getAll();
    } catch (_) {}

    if (map != null) {
      map1 = map['host'];
      map2 = map['main_image'];
    }
    _host = _applyString(map1, 'http://10.0.2.2:3000');
    _mainImage = _applyString(map2, 'https://i.imgur.com/f9iZ0wB.png');
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
