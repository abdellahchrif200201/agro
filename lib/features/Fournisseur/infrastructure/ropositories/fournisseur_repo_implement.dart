


import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/data/fournisseur_remote_data_source.dart';
import 'package:devti_agro/features/Fournisseur/infrastructure/ropositories/fournisseur_repo.dart';



class FournisseurRepoImplement implements FournisseurRepo {
  final FournisseurRemoteDataSource fournisseurRemoteDataSource;
  final NetworkInfo networkInfo;

  FournisseurRepoImplement({
    required this.fournisseurRemoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<Fournisseur>>> getAllFournisseur() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFournisseurResponse = await fournisseurRemoteDataSource.getAllFournisseur();
        return right(remoteFournisseurResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print('Unexpected error Fournisseur: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
  
  
  
  
 

  
}
