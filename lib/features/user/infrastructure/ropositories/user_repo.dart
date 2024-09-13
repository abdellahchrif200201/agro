import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';


/// Abstract repository interface for fetching zones.
abstract class UserRepo {
  
  Future<Either<Failure, List<User>>> getAllUser();


  Future<Either<Failure, Unit>> deleteUser(int id);
  Future<Either<Failure, Unit>> addUser(User user);
  Future<Either<Failure, Unit>> updateUser(User user);
  Future<Either<Failure, User>> showUser(int idUser);
    Future<Either<Failure, List<User>>> getUserByName(String name);

  
}
