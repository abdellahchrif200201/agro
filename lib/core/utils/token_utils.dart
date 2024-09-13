// // lib/core/utils/token_utils.dart
// import 'package:shared_preferences/shared_preferences.dart';

// Future<bool> isTokenPresent() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('auth_token');
//   final name = prefs.getString('user_info');
//   print(name[""]);
//   return token?.isNotEmpty ?? false;
// }

import 'package:devti_agro/core/utils/loger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For jsonDecode

Future<bool> isTokenPresent() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final userInfoJson = prefs.getString('user_info');

  // Decode user info if it exists
  if (userInfoJson != null) {
    try {
      final userInfo = jsonDecode(userInfoJson);
      logger.d(userInfo); // Print the entire user info map
      // You can print specific fields if needed
      logger.d(userInfo['name']); // Example: print the user's name
    } catch (e) {
      logger.d('Error decoding user info: $e');
    }
  } else {
    logger.d('No user info found');
  }

  return token?.isNotEmpty ?? false;
}
