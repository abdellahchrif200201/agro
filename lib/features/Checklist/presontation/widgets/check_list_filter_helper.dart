import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/features/Checklist/application/bloc/get_all_check_list/check_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListFilterHelper {
  final BuildContext context;
  bool isAsN = true;
  bool isAsD = true;

  CheckListFilterHelper(this.context);

  void openFilterSheet() {
    showFilterBottomSheet(
      context: context,
      title: 'Filter by',
      filterOptions: ['nom', 'date'],
      filterActions: {
        'nom': () {
          if (isAsN) {
            BlocProvider.of<CheckListBloc>(context).add(const FilterCheckListEvent(filterType: 'nom', isAscending: true));
            isAsN = false;
          } else {
            BlocProvider.of<CheckListBloc>(context).add(const FilterCheckListEvent(filterType: 'nom', isAscending: false));
            isAsN = true;
          }
          Navigator.pop(context);
        },
        'date': () {
          if (isAsD) {
            BlocProvider.of<CheckListBloc>(context).add(const FilterCheckListEvent(filterType: 'date', isAscending: true));
            isAsD = false;
          } else {
            BlocProvider.of<CheckListBloc>(context).add(const FilterCheckListEvent(filterType: 'date', isAscending: false));
            isAsD = true;
          }
          Navigator.pop(context);
        },
      },
    );
  }
}
