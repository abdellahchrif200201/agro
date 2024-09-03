import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/infrastructure/datasource/checkList_remote_data_source.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class CheckListRepositoriesImplement implements CheckListRepositories {
  final ChecklistRemoteDataSource checklistRemoteDataSource;
  final NetworkInfo networkInfo;

  CheckListRepositoriesImplement({required this.checklistRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<CheckList>>> getAllCheckList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCheckListResponse = await checklistRemoteDataSource.getAllCheckList();
        return right(remoteCheckListResponse);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        print("unexpected error , $e");
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CheckList>>> getCheckListsByDateRange(DateTimeRange dateRange) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCheckListsResponse = await checklistRemoteDataSource.getAllCheckList();

        final filteredCheckLists = remoteCheckListsResponse.where((checkList) {
          try {
            // Parse the date string from checkList to DateTime
            final createdAt = DateTime.parse(checkList.date!); // Assuming checkList.date is a String

            // Check if the parsed date is within the specified range
            return createdAt.isAfter(dateRange.start) && createdAt.isBefore(dateRange.end);
          } catch (e) {
            // Handle parsing error if date is not valid
            print('Date parsing error: $e');
            return false;
          }
        }).toList();

        return right(filteredCheckLists);
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
  Future<Either<Failure, List<CheckList>>> getCheckListsByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCheckListsResponse = await checklistRemoteDataSource.getAllCheckList();
        final List<CheckList> checkLists = remoteCheckListsResponse.map((json) => CheckListModel.fromJson(json as Map<String, dynamic>)).toList();
        final filteredCheckList = checkLists.where((chickList) {
          return chickList.description!.toLowerCase().contains(name.toLowerCase());
        }).toList();
        return right(filteredCheckList);
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
