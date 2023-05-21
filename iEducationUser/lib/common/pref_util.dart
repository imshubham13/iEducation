import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? pref;

  static Future<SharedPreferences> get init async =>
      pref = await SharedPreferences.getInstance();

  static set setMobileNumber(String data) =>
      pref!.setString(SharedKey.userMobileNumber, data);

  static String? get getMobileNumber =>
      pref!.getString(SharedKey.userMobileNumber);

  static set setIsScanned(bool data) =>
      pref!.setBool(SharedKey.isScanned, data);

  static bool? get getIsScanned => pref!.getBool(SharedKey.isScanned);

  static set setScannedDate(String date) =>
      pref!.setString(SharedKey.scannedDate, date);
  static String? get getScannedDate  =>
      pref!.getString(SharedKey.scannedDate);
}

class SharedKey {
  static const userMobileNumber = 'userMobileNumber';

  static const isScanned = 'isScanned';

  static const scannedDate = 'scannedDate';
}
