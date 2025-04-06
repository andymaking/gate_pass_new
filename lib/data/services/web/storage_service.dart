import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  Future<bool> storeItem({required String key, dynamic value}) async {
    await box.write(key, value);
    return hasData(key: key);
  }

  Future<dynamic> readItem({required String key}) async {
    final value = await box.read(key);
    return value;
  }

  Future<String?> read({required String key}) async {
    final value = await box.read(key);
    return value;
  }

  Future<bool> hasData({required String key}) async {
    final value = box.hasData(key);
    return value;
  }

  deleteItem({required String key}) async {
    await box.remove(key);
  }

  deleteAllItems() async {
    await box.erase();
  }

}

class StorageKey {

  static const String userTableKey = 'user';
  static const String appAllCurrencyList = 'appAllCurrencyList';
  static const String tokenTableKey = '/token';
  static const String walletBalance = '/Wallet/balance';
  static const String bioDataInfo = '/bioDataInfo';
  static const String referralCode = '/referralCode';
  static const String refreshTokenKey = '/refresh_token';
  static const String appFirstTimeKey = 'isFirstTime';
  static const String fcmToken = 'FCMTOKEN';
  static const String isDarkModeKey = 'isAppOnDarkMode';
  static const String onboardingTableKey = 'onboarding';
  static const String languageCode = 'languageCode';
  static const String appCurrency = 'appCurrency';
  static const String notificationCategories = 'notificationCategories';

}