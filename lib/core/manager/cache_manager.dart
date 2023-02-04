import 'package:gs_diamond/core/constants/app_cache_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gs_diamond/core/error/exceptions.dart';

abstract class CacheManager {
  Future<dynamic> request({
    String cacheName,
    String method,
    String key,
    String value,
  });
}

class CacheManagerImpl extends CacheManager {
  SharedPreferences? initSharedPref;

  CacheManagerImpl({this.initSharedPref});

  @override
  Future request(
      {String? cacheName, String? method, String? key, String? value}) async {
    // TODO: implement request
    try {
      switch (method) {
        case CacheConstants.getString:
          return initSharedPref?.getString(key!);
        case CacheConstants.getInt:
          return initSharedPref?.getInt(key!);
        case CacheConstants.getDouble:
          return initSharedPref?.getDouble(key!);
        case CacheConstants.getBool:
          return initSharedPref?.getBool(key!);
        case CacheConstants.setString:
          return initSharedPref?.setString(key!, value.toString());
        case CacheConstants.setInt:
          return initSharedPref?.setInt(key!, int.parse(value!));
        case CacheConstants.setDouble:
          return initSharedPref?.setDouble(key!, double.parse(value!));
        case CacheConstants.setBool:
          return initSharedPref?.setBool(
              key!, value!.contains("true") ? true : false);
        case CacheConstants.delete:
          return initSharedPref?.remove(key!);
        case CacheConstants.deleteAll:
          return initSharedPref?.clear();
      }
    } catch (error) {
      throw ServerException();
    }
  }
}
