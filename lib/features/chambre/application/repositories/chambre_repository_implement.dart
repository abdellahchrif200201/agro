import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/chambre/application/datasource/chambre_remote_data_source.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/domain/repositories/chambre_repositories.dart';
import 'package:flutter/material.dart';

import '../models/chambre_model.dart';

class ChambreRepositoryImplement implements ChambresRepository {
  final ChambreRemoteDataSource chambreRemoteDataSource;
  final NetworkInfo networkInfo;

  ChambreRepositoryImplement({
    required this.chambreRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Chambre>>> getAllChambres() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChambresResponse = await chambreRemoteDataSource.getAllChambre();
        return right(remoteChambresResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Chambre>>> getChambresByDateRange(DateTimeRange dateRange) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChambresResponse = await chambreRemoteDataSource.getAllChambre();
        final filteredChambres = remoteChambresResponse.where((chambre) {
          final createdAt = chambre.createdAtDateTime;
          return createdAt!.isAfter(dateRange.start) && createdAt.isBefore(dateRange.end);
        }).toList();
        return right(filteredChambres);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
  
 @override
  Future<Either<Failure, List<Chambre>>> getChambresByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChambresResponse = await chambreRemoteDataSource.getAllChambre();
        final List<Chambre> chambres = remoteChambresResponse
            .map((json) => ChambreModel.fromJson(json as Map<String, dynamic>))
            .toList();
        final filteredChambres = chambres.where((chambre) {
          return chambre.name.toLowerCase().contains(name.toLowerCase());
        }).toList();
        return right(filteredChambres);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> addChambre(Chambre chambre) async {
    if (await networkInfo.isConnected) {
      final chambreModel = ChambreModel(name: chambre.name ,surface: chambre.surface ,temperature: chambre.temperature ,zoneId: chambre.zoneId , entrepriseICE: chambre.entrepriseICE);
      try {
        return await _getMessage(() => chambreRemoteDataSource.addChambre(chambreModel));
      } catch (e) {
        print('add chambres Repo Error: $e'); // Print the exact error caught
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
