import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';

class TacheService {
  final AddDeleteUpdateTacheBloc bloc;

  TacheService({required this.bloc});

  Future<bool> addTache(CheckListModel tache) async {
    bloc.add(AddTacheEvent(tache: tache));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
    );

    return state is MessageAddDeleteUpdateTacheState && state.message == ADD_SUCCESS_MESSAGE;
  }

  Future<bool> updateTache(CheckListModel tache) async {
    bloc.add(UpdateTacheEvent(tache: tache));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
    );

    return state is MessageAddDeleteUpdateTacheState && state.message == UPDATE_SUCCESS_MESSAGE;
  }
}
