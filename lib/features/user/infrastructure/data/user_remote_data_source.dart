import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
// import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/api/api_route.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUser();
  Future<UserModel> showUser(int userId);
  Future<Unit> deleteUser(int userId);
  Future<Unit> addUser(UserModel userModel);
  Future<Unit> updateUser(UserModel userModel);
}

class UserRemoteDataSourceImplement implements UserRemoteDataSource {
  final Logger _logger = Logger();

  final http.Client client;
  UserRemoteDataSourceImplement({required this.client});
  @override
  Future<List<UserModel>> getAllUser() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/User/1"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      // final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;

      final List<dynamic> data = decodedJson['data'];
      final List<UserModel> chambresModel = data.map<UserModel>((jsonChambreModel) {
        return UserModel.fromJson({'data': jsonChambreModel, 'meta': decodedJson['meta']});
      }).toList();
      // final List<dynamic> data = decodedJson['data'];

      // final List<UserModel> roleModel = data.map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel)).toList();

      return chambresModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUser(int userId) async {
    final response = await client.delete(
      Uri.parse("$BASE_URL/MOBILE/User/${userId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      _logger.d('is deleted');
      return Future.value(unit);
    } else {
      _logger.d('not deletd');
      throw ServerException();
    }
  }

  @override
  Future<Unit> addUser(UserModel userModel) async {
    // Prepare the body map
    final Map<String, dynamic> body = {
      "name": userModel.name,
      "Image": userModel.image,
      "entrepriseId": userModel.entrepriseId,
      "email": userModel.email,
      "telephone": userModel.telephone,
      "adresse": userModel.adresse,
      "pays": userModel.pays,
      "ville": userModel.ville,
      "password": userModel.password
    };

    // Convert the body to a JSON string
    final String jsonBody = json.encode(body);

    try {
      // Perform the POST request
      final response = await client.post(
        Uri.parse("$BASE_URL/WEB/User"),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      // Decode the response body
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Handle the response
      if (response.statusCode == 200) {
        if (responseBody['status'] == 201) {
          _logger.d("User added successfully. Response body: ${response.body}");
          return Future.value(unit);
        } else {
          _logger.d("User not added. Response body: ${response.body}");
          throw ServerException();
        }
      } else {
        // Log more details about the error
        _logger.d("Error adding user. Status code: ${response.statusCode}");
        _logger.d("Response body: ${response.body}");

        final errorMessage = responseBody['message'] ?? 'Unknown error';
        _logger.d("Error message from server: $errorMessage");

        throw ServerException();
      }
    } catch (e) {
      // Catch and log exceptions
      _logger.d("Exception occurred: $e");
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateUser(UserModel userModel) async {
    final userId = userModel.id.toString();
    _logger.d("iddddddddddddddddd $userId");

    final taskName = userModel.name;

    _logger.d("iddddddddddddddddd $taskName");

    final body = {
      "name": userModel.name,
      "Image": userModel.image,
      "entrepriseId": userModel.entrepriseId,
      "email": userModel.email,
      "telephone": userModel.telephone,
      "adresse": userModel.adresse,
      "pays": userModel.pays,
      "ville": userModel.ville,
      "password": userModel.password
    };

    final response = await client.put(
      Uri.parse("$BASE_URL/WEB/User/$userId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    final Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['status'] == 201) {
        _logger.d("User added successfully. Response body: ${response.body}");
        return Future.value(unit);
      } else {
        _logger.d("User not added. Response body: ${response.body}");
        throw ServerException();
      }
    } else {
      // Log more details about the error
      _logger.d("Error adding user. Status code: ${response.statusCode}");
      _logger.d("Response body: ${response.body}");

      final errorMessage = responseBody['message'] ?? 'Unknown error';
      _logger.d("Error message from server: $errorMessage");

      throw ServerException();
    }
  }

  @override
  Future<UserModel> showUser(int userId) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/WEB/User/show/$userId"), // Correctly use the userId parameter
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      //_logger.d(response.body); // Use logger for debug logging
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      final Map<String, dynamic> userData = decodedJson['data'];

      final UserModel userModel = UserModel.fromJson({
        'data': userData,
      });

      return userModel;
    } else {
      //_logger.e(response.body); // Use logger for error logging
      throw ServerException();
    }
  }
}
