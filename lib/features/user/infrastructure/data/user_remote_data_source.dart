import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUser();
  Future<Unit> deletePost(int postId);
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
  Future<Unit> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }
}
