import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/domain/repositories/check_list_repositories.dart';

class GetAllCheckListUseCase{
  final CheckListRepositories checkListRepositories;
  GetAllCheckListUseCase({
    required this.checkListRepositories
  });

  Future<Either<Failure , List<CheckList>>> call() async{
    return await checkListRepositories.getAllCheckList();
  }
}