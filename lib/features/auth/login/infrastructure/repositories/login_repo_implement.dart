import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/auth/login/infrastructure/dataSource/login_remote_data_source.dart';
import 'package:devti_agro/features/auth/login/aplication/model/Login_model.dart';
import 'package:devti_agro/features/auth/login/domain/entities/login.dart';
import 'package:devti_agro/features/auth/login/domain/repositories/login_repo.dart';

class LoginRepoImplement implements LoginRepo {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepoImplement({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> loginAuth(Login login) async {
    if (await networkInfo.isConnected) {
      final loginModel = LoginModel(email: login.email, password: login.password);
      try {
        return await _getMessage(() => remoteDataSource.loginAuth(loginModel));
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
