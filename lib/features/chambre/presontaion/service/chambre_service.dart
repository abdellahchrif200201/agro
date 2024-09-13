import 'package:devti_agro/features/chambre/application/bloc/create_chambre_bloc/add_chambre_bloc.dart';
import 'package:devti_agro/features/chambre/application/bloc/delete_update_chambre/delete_update_chambre_bloc.dart';
import 'package:devti_agro/features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/strings/failures.dart';

class ChambreService {
  Future<void> updateChambre(
    BuildContext context,
    ChambreModel chambreModel,
    Function setStateCallback,
  ) async {
    final bloc = BlocProvider.of<AddDeleteUpdateChambreBloc>(context);

    bloc.add(UpdateChambreEvent(chambre: chambreModel));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorDeleteUpdateChambreState || state is MessageDeleteUpdateChambreState,
    );

    if (state is MessageDeleteUpdateChambreState && state.message == UPDATE_SUCCESS_MESSAGE) {
      setStateCallback(false);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "The chambre is updated",
        ),
      );
      context.read<ChambresBloc>().add(RefreshChambresEvent());
    } else {
      setStateCallback(false);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "The chambre is not updated",
        ),
      );
    }
  }

  Future<void> addChambre(
    BuildContext context,
    ChambreModel chambreModel,
    Function setStateCallback,
  ) async {
    final bloc = BlocProvider.of<AddChambreBloc>(context);

    bloc.add(AddChambreButtonPressed(chambre: chambreModel));

    final state = await bloc.stream.firstWhere(
      (state) => state is AddChambreFailure || state is AddChambreSuccess,
    );

    if (state is AddChambreSuccess) {
      setStateCallback(false);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(
          message: "The chambre is added",
        ),
      );
      context.read<ChambresBloc>().add(RefreshChambresEvent());
    } else {
      setStateCallback(false);
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "The chambre is not added",
        ),
      );
    }
  }
}
