import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/auth/register/infrastructure/datasource/register_remote_data_source.dart';
import 'package:devti_agro/features/auth/register/application/models/register_model.dart';
import 'package:devti_agro/features/auth/register/domain/entities/register.dart';
import 'package:devti_agro/features/auth/register/infrastructure/repositories/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final RegisterRemoteDataSource registerRemoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepoImpl({
    required this.networkInfo,
    required this.registerRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> registerAuth(Register register) async {
    if (await networkInfo.isConnected) {
      final registerModel = RegisterModel(email: register.email, password: register.password, name: register.name , entrepriseICE: register.entrepriseICE);
      try {
        return await _getMessage(() => registerRemoteDataSource.registerAuth(registerModel));
      } catch (e) {
        print('Login Repo Error: $e'); // Print the exact error caught
        return Left(ServerFailure());
      }
    } else {
      print('No internet connection');
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, T>> _getMessage<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e) {
      print('Error in _getMessage: $e'); // Print error in detail
      return Left(ServerFailure());
    }
  }

 
}
