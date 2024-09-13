import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For jsonDecode


class UserInfoService {
  Future<Map<String, dynamic>?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoJson = prefs.getString('user_info');
    if (userInfoJson != null) {
      try {
        final userInfo = jsonDecode(userInfoJson);
        return userInfo;
      } catch (e) {
        print('Error decoding user info: $e');
        return null;
      }
    }
    return null;
  }
}


