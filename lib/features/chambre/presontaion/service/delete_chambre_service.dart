import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/chambre/application/bloc/delete_update_chambre/delete_update_chambre_bloc.dart';
import 'package:devti_agro/features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChambreDeletionService {
  final BuildContext context;

  ChambreDeletionService(this.context);

  Future<void> deleteChambre(int id) async {
    final deleteBloc = BlocProvider.of<AddDeleteUpdateChambreBloc>(context);

    deleteBloc.add(DeleteChambreEvent(chambreId: id));

    final state = await deleteBloc.stream.firstWhere(
      (state) => state is ErrorDeleteUpdateChambreState || state is MessageDeleteUpdateChambreState,
    );

    if (state is MessageDeleteUpdateChambreState) {
      if (state.message == DELETE_SUCCESS_MESSAGE) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chambre deleted successfully')),
        );
        BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'nom', isAscending: true));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete chambre')),
        );
      }
    } else if (state is ErrorDeleteUpdateChambreState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }
}
