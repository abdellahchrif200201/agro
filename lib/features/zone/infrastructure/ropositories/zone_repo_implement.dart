


import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/zone/domain/entities/zone.dart';
import 'package:devti_agro/features/zone/domain/repositories/zone_repo.dart';
import 'package:devti_agro/features/zone/infrastructure/data/zone_remote_data_source.dart';

class ZoneRepoImplement implements ZoneRepo {
  final ZoneRemoteDataSource zoneRemoteDataSource;
  final NetworkInfo networkInfo;

  ZoneRepoImplement({
    required this.zoneRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Zone>>> getAllZoneByEntreprise(int idEntreprise) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteZoneResponse = await zoneRemoteDataSource.getAllZoneByEntreprise(idEntreprise);
        return right(remoteZoneResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error zone: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

 

  
}
