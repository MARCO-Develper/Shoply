import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setString(key, value);
    }
  }

  static Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }

  static Object? getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<String?> getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  //! Save user data to SharedPreferences
  // static Future<void> saveDataUserPref(UserDataModel? user) async {
  //   if (user == null) return;

  //   final String userJson = jsonEncode(user.toJson());

  //   await sharedPreferences.setString('user_data', userJson);
  // }

  //! Retrieve user data from SharedPreferences
  // static Future<UserDataModel?> getDataUserPref() async {
  //   final String? userJson = sharedPreferences.getString('user_data');
  //   if (userJson != null) {
  //     final userMap = jsonDecode(userJson) as Map<String, dynamic>;

  //     return UserDataModel.fromJson(userMap);
  //   }
  //   return null;
  // }

  //! Clear user data from SharedPreferences
  // static Future<void> clearDataUserPref() async {
  //   await sharedPreferences.remove('user_data');
  // }
}
