import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/infrastructure/data/user_remote_data_source.dart';
import 'package:devti_agro/features/user/infrastructure/ropositories/user_repo.dart';

typedef Future<Unit> DeleteOrUpdateOrAddUser();

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
  Future<Either<Failure, Unit>> deleteUser(int id) async {
    return await _getMessage(() {
      return userRemoteDataSource.deleteUser(id);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddUser deleteOrUpdateOrAddUser) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddUser();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addUser(User user) async {
    final UserModel userModel = UserModel(
        name: user.name,
        entrepriseId: user.entrepriseId,
        adresse: user.adresse,
        email: user.email,
        image: user.image,
        password: user.password,
        pays: user.password,
        ville: user.ville,
        telephone: user.telephone);

    return await _getMessage(() {
      return userRemoteDataSource.addUser(userModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateUser(User user) async {
    final UserModel userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      entrepriseId: user.entrepriseId,
      pays: user.pays,
      ville: user.ville,
      adresse: user.adresse,
      image: user.image,
      telephone: user.telephone,
    );

    return await _getMessage(() {
      return userRemoteDataSource.updateUser(userModel);
    });
  }
}
