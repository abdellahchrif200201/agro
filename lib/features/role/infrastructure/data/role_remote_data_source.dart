import 'dart:convert';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/features/role/aplication/model/role_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/api_route.dart';

abstract class RoleRemoteDataSource {
  Future<List<RoleModel>> getAllRole();
}


class RoleRemoteDataSourceImplement implements RoleRemoteDataSource {
  final http.Client client;
  RoleRemoteDataSourceImplement({required this.client});
  @override
  Future<List<RoleModel>> getAllRole() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/MOBILE/Role"),
      headers: {
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = decodedJson['data'];

      final List<RoleModel> roleModel = data.map<RoleModel>((jsonRoleModel) => RoleModel.fromJson(jsonRoleModel)).toList();

      return roleModel;
    } else {
      throw ServerException();
    }
  }
}
