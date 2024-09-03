import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/nutrition/infrastructure/datasource/nutrition_remote_data_source.dart';
import 'package:devti_agro/features/nutrition/domain/entities/nutrition.dart';
import 'package:devti_agro/features/nutrition/infrastructure/repositories/nutiration_repositories.dart';

class NutritionRepositoriesImplement implements NutirationRepositories{

  final NutritionRemoteDataSource nutritionRemoteDataSource;
  final NetworkInfo networkInfo ;

  NutritionRepositoriesImplement({
    required this.nutritionRemoteDataSource,
    required this.networkInfo
});


  @override
  Future<Either<Failure, List<Nutrition>>> getAllNutrition() async {
    if(await networkInfo.isConnected){
      try{
        final remoteNutritionResponse = await nutritionRemoteDataSource.getAllNutrition();
        return right(remoteNutritionResponse);
      }on  ServerException{
        return left(ServerFailure());
      }catch(e){
        print("unexpected error , $e");
        return left(UnexpectedFailure());
      }
    }else{
      return left(OfflineFailure());
    }
  }

  // @override
  // Future<Either<Failure, List<Tracabilte>>> getTracabiltesByDateRange(DateTimeRange dateRange) async {
  //  if (await networkInfo.isConnected) {
  //     try {
  //       final remoteTracabilteResponse = await tracabiliteRemoteDataSource.getAllTracabilite();

  //       final filteredTracabilte = remoteTracabilteResponse.where((checkList) {
  //         try {
  //           // Parse the date string from checkList to DateTime
  //           final createdAt = DateTime.parse(checkList.dateCreate); // Assuming checkList.date is a String

  //           // Check if the parsed date is within the specified range
  //           return createdAt.isAfter(dateRange.start) && createdAt.isBefore(dateRange.end);
  //         } catch (e) {
  //           // Handle parsing error if date is not valid
  //           print('Date parsing error: $e');
  //           return false;
  //         }
  //       }).toList();

  //       return right(filteredTracabilte);
  //     } on ServerException {
  //       return left(ServerFailure());
  //     } catch (e) {
  //       print('Unexpected error: $e');
  //       return left(UnexpectedFailure());
  //     }
  //   } else {
  //     return left(OfflineFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, List<Tracabilte>>> getTracabiltesByName(String name) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteTracabiliteResponse = await tracabiliteRemoteDataSource.getAllTracabilite();
  //       final List<Tracabilte> tracabilte = remoteTracabiliteResponse.map((json) => TracabiliteModel.fromJson(json as Map<String, dynamic>)).toList();
  //       final filteredTracabilte = tracabilte.where((tracabilite) {
  //         return tracabilite.name.toLowerCase().contains(name.toLowerCase());
  //       }).toList();
  //       return right(filteredTracabilte);
  //     } on ServerException {
  //       return left(ServerFailure());
  //     } catch (e) {
  //       print('Unexpected error: $e');
  //       return left(UnexpectedFailure());
  //     }
  //   } else {
  //     return left(OfflineFailure());
  //   }
  // }

}