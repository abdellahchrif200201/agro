


import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/role/domain/entities/role.dart';
import 'package:devti_agro/features/role/domain/repositories/role_repo.dart';
import 'package:devti_agro/features/role/infrastructure/data/role_remote_data_source.dart';


class RoleRepoImplement implements RoleRepo {
  final RoleRemoteDataSource roleRemoteDataSource;
  final NetworkInfo networkInfo;

  RoleRepoImplement({
    required this.roleRemoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<Role>>> getAllRole() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRoleResponse = await roleRemoteDataSource.getAllRole();
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
