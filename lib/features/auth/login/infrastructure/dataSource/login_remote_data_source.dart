import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/auth/login/aplication/model/Login_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/api/api_route.dart';

// Abstract class defining the contract for the remote data source
abstract class LoginRemoteDataSource {
  Future<Unit> loginAuth(LoginModel loginModel);
}

// Implementation of the remote data source
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  var logger = Logger();

  @override
  Future<Unit> loginAuth(LoginModel loginModel) async {
    final body = jsonEncode({
      "email": loginModel.email,
      "password": loginModel.password,
    });

    final response = await client.post(
      Uri.parse('$BASE_URL/Auth/Login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseBody["status"] == 200) {
        // Login successful, save the token
        final prefs = await SharedPreferences.getInstance();
        final token = responseBody['token'];

        logger.d(token);

        // Save token
        await prefs.setString('auth_token', token);

        // Save user info
        final user = responseBody['user'];
        final userJson = jsonEncode(user);
        await prefs.setString('user_info', userJson);

        logger.d(responseBody);
        logger.d("Login successful");

        return Future.value(unit);
      } else {
        // Handle unexpected response codes or messages
        throw ServerException(message: responseBody['Error_message'] ?? 'Unexpected error');
      }
    } else {
      final errorMessage = responseBody['Error_message'] ?? 'Server error';
      throw ServerException(message: errorMessage);
    }
  }

  // // Method to retrieve the stored token
  // Future<String?> getAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('auth_token');
  // }
}
