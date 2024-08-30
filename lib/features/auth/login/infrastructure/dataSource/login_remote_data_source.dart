import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/auth/login/aplication/model/Login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Abstract class defining the contract for the remote data source
abstract class LoginRemoteDataSource {
  Future<Unit> loginAuth(LoginModel loginModel);
}

const BASE_URL = "https://agroapp.devtitechnologie.pro/api/Auth";

// Implementation of the remote data source
class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> loginAuth(LoginModel loginModel) async {
    final body = jsonEncode({
      "email": loginModel.email,
      "password": loginModel.password,
    });

    final response = await client.post(
      Uri.parse('$BASE_URL/Login'),
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
        await prefs.setString('auth_token', token);
        await prefs.setString('name' , responseBody['user']['name'] );

        print(responseBody);
        print("Login successful");
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
