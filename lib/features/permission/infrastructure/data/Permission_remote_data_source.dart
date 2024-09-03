import 'dart:convert';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/permission/aplication/model/Permission_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class PermissionRemoteDataSource {
  Future<List<PermissionModel>> getAllPermission();
}


class PermissionRemoteDataSourceImplement implements PermissionRemoteDataSource {
  final http.Client client;
  PermissionRemoteDataSourceImplement({required this.client});
  @override
  Future<List<PermissionModel>> getAllPermission() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Permission"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<PermissionModel> roleModel = data.map<PermissionModel>((jsonPermissionModel) => PermissionModel.fromJson(jsonPermissionModel)).toList();

      return roleModel;
    } else {
      throw ServerException();
    }
  }
}
