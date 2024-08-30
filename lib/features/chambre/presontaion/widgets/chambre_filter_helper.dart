import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/features/chambre/presontaion/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChambreFilterHelper {
  final BuildContext context;
  bool isAsN = true;
  bool isAsS = true;
  bool isAsT = true;

  ChambreFilterHelper(this.context);

  void openFilterSheet() {
    showFilterBottomSheet(
      context: context,
      title: 'Filter by',
      filterOptions: ['nom', 'temperature', 'surface'],
      filterActions: {
        'nom': () {
          if (isAsN) {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'nom', isAscending: true));
            isAsN = false;
          } else {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'nom', isAscending: false));
            isAsN = true;
          }
          context.pop();
        },
        'temperature': () {
          if (isAsT) {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'temperature', isAscending: true));
            isAsT = false;
          } else {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'temperature', isAscending: false));
            isAsT = true;
          }
          context.pop();
        },
        'surface': () {
          if (isAsS) {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'surface', isAscending: true));
            isAsS = false;
          } else {
            BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'surface', isAscending: false));
            isAsS = true;
          }
          context.pop();
        },
      },
    );
  }
}
