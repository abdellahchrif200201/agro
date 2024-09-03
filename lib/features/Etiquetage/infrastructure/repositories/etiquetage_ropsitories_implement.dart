import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/datasource/etiquetage_remote_data_source.dart';
import 'package:devti_agro/features/Etiquetage/domain/entities/etiquetage.dart';
import 'package:devti_agro/features/Etiquetage/infrastructure/repositories/etiquetage_repositories.dart';
import 'package:flutter/src/material/date.dart';

class EtiquetageRopsitoriesImplement implements EtiquetageRepositories {
  final EtiquetageRemoteDataSource etiquetageRemoteDataSource;
  final NetworkInfo networkInfo;

  EtiquetageRopsitoriesImplement({required this.etiquetageRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Etiquetage>>> getAllEtiquetage() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEtiquetageResponse = await etiquetageRemoteDataSource.getAllEtiquetage();
        return right(remoteEtiquetageResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print("unexpected error Etiquetage ; $e");
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Etiquetage>>> getEtiquetageByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEtiquetageResponse = await etiquetageRemoteDataSource.getAllEtiquetage();
        final List<Etiquetage> etiquetages = remoteEtiquetageResponse
            .map(
              (etiquetageModel) => etiquetageModel as Etiquetage,
            )
            .toList();

        final filteredEtiquetage = etiquetages.where((etiquetage) {
          return etiquetage.name.toLowerCase().contains(name.toLowerCase());
        }).toList();

        return right(filteredEtiquetage);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print("Filter Etiquetage by name: $e");
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Etiquetage>>> getEtiquetagesByDateRange(DateTimeRange dateRange) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEtiquetageResponse = await etiquetageRemoteDataSource.getAllEtiquetage();

        final filteredEtiquetage = remoteEtiquetageResponse.where((checkList) {
          try {
            // Parse the date string from checkList to DateTime
            final createdAt = DateTime.parse(checkList.dateDDM); // Assuming checkList.date is a String

            // Check if the parsed date is within the specified range
            return createdAt.isAfter(dateRange.start) && createdAt.isBefore(dateRange.end);
          } catch (e) {
            // Handle parsing error if date is not valid
            print('Date parsing error: $e');
            return false;
          }
        }).toList();

        return right(filteredEtiquetage);
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
}
