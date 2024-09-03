
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/auth/register/application/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/api/api_route.dart';

// Abstract class defining the contract for the remote data source
abstract class RegisterRemoteDataSource {
  Future<String> registerAuth(RegisterModel registerModel);
}


// Implementation of the remote data source
class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final http.Client client;

  RegisterRemoteDataSourceImpl({required this.client});

  @override
  Future<String> registerAuth(RegisterModel registerModel) async {
    final body = jsonEncode({
      "name": registerModel.name,
      "email": registerModel.email,
      "password": registerModel.password,
      "EntrepriseICE": registerModel.entrepriseICE,
    });

    final response = await client.post(
      Uri.parse('$BASE_URL/Auth/Register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseBody["success"] == true) {
        
        
        print(responseBody);
        print("Registration successful");
        return responseBody["Message"]; // Return the token
      } else {
        // Handle unexpected response codes or messages
        throw ServerException(message: responseBody['Error_message'] ?? 'Unexpected error');
      }
    } else {
      final errorMessage = responseBody['Error_message'] ?? 'Server error';
      throw ServerException(message: errorMessage);
    }
  }
}
