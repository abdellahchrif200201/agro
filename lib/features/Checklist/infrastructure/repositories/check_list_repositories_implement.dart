import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/exeptions.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/core/network/network_info.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/infrastructure/datasource/checkList_remote_data_source.dart';
import 'package:devti_agro/features/Checklist/infrastructure/repositories/check_list_repositories.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/loger.dart';
// import 'package:flutter/material.dart';

typedef Future<Unit> DeleteOrUpdateOrAddTash();
// typedef Future<Unit> DeleteOrUpdateOrAddPost();

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
        logger.d("unexpected error , $e");
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
            logger.d('Date parsing error: $e');
            return false;
          }
        }).toList();

        return right(filteredCheckLists);
      } on ServerException {
        return left(ServerFailure());
      } catch (e) {
        logger.d('Unexpected error: $e');
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
        logger.d('Unexpected error: $e');
        return left(UnexpectedFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  // @override
  // Future<Either<Failure, Unit>> deleteTache(int id) async {
  //   return await _getMessage(() {
  //     return checklistRemoteDataSource.deleteTache(id);
  //   });
  // }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddTash deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTache(CheckList checkList) async {
    final CheckListModel checkListModel = CheckListModel(
        tasksName: checkList.tasksName,
        entrepriseId: checkList.entrepriseId,
        date: checkList.date,
        type: checkList.type,
        status: checkList.status,
        description: checkList.description,
        userId: checkList.userId);

    return await _getMessage(() {
      return checklistRemoteDataSource.addTache(checkListModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTache(int id) async {
    return await _getMessage(() {
      return checklistRemoteDataSource.deleteTache(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateTache(CheckList checkList) async {
    final CheckListModel checkListModel = CheckListModel(
        id: checkList.id,
        category: checkList.category,
        date: checkList.date,
        description: checkList.description,
        entrepriseId: checkList.entrepriseId,
        message: checkList.message,
        status: checkList.status,
        tasksName: checkList.tasksName,
        type: checkList.type,
        userId: checkList.userId,
        userName: checkList.userName);

    return await _getMessage(() {
      return checklistRemoteDataSource.updateTache(checkListModel);
    });
  }
}
