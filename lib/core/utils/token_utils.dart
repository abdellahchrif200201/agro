// lib/core/utils/token_utils.dart
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isTokenPresent() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final name = prefs.getString('name');
  print(name);
  return token?.isNotEmpty ?? false;
}
