import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUser();
  Future<Unit> deleteUser(int userId);
  Future<Unit> addUser(UserModel userModel);
  Future<Unit> updateUser(UserModel userModel);
}

class UserRemoteDataSourceImplement implements UserRemoteDataSource {
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
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<UserModel> roleModel = data.map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel)).toList();

      return roleModel;
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
      print('is deleted');
      return Future.value(unit);
    } else {
      print('not deletd');
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
          print("User added successfully. Response body: ${response.body}");
          return Future.value(unit);
        } else {
          print("User not added. Response body: ${response.body}");
          throw ServerException();
        }
      } else {
        // Log more details about the error
        print("Error adding user. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");

        final errorMessage = responseBody['message'] ?? 'Unknown error';
        print("Error message from server: $errorMessage");

        throw ServerException();
      }
    } catch (e) {
      // Catch and log exceptions
      print("Exception occurred: $e");
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateUser(UserModel userModel) async {
    final userId = userModel.id.toString();
    print("iddddddddddddddddd $userId");

    final taskName = userModel.name;

    print("iddddddddddddddddd $taskName");

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
        print("User added successfully. Response body: ${response.body}");
        return Future.value(unit);
      } else {
        print("User not added. Response body: ${response.body}");
        throw ServerException();
      }
    } else {
      // Log more details about the error
      print("Error adding user. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      final errorMessage = responseBody['message'] ?? 'Unknown error';
      print("Error message from server: $errorMessage");

      throw ServerException();
    }
  }
}
