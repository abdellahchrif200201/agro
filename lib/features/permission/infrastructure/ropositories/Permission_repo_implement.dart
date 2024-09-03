


import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/permission/domain/entities/permission.dart';
import 'package:devti_agro/features/permission/infrastructure/data/Permission_remote_data_source.dart';
import 'package:devti_agro/features/permission/infrastructure/ropositories/permission_repo.dart';



class PermissionRepoImplement implements PermissionRepo {
  final PermissionRemoteDataSource permissionRemoteDataSource;
  final NetworkInfo networkInfo;

  PermissionRepoImplement({
    required this.permissionRemoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<Permission>>> getAllPermission() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRoleResponse = await permissionRemoteDataSource.getAllPermission();
        return right(remoteRoleResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error Role: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

 

  
}
