import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<void> storeLocalData(
      {required String key, required String value}) async {
    log("storing key $key value $value");
    await storage.write(key: key, value: value);
  }

  Future<String?> getLocalData({required String key}) async {
    log("geting key $key");

    return await storage.read(key: key);
  }

  Future<void> removeLocalData() async {
    await storage.deleteAll();
  }
}
