


import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/infrastructure/data/user_remote_data_source.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';


class UserRepoImplement implements UserRepo {
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepoImplement({
    required this.userRemoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<User>>> getAllUser() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserResponse = await userRemoteDataSource.getAllUser();
        return right(remoteUserResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error User: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
  

  
 

  
}
