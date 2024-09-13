// import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_is_empty/custom_data_is_empty.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/loading_widget.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/Etiquetage/aplication/bloc/etiquetage_bloc.dart';
import 'package:devti_agro/features/Etiquetage/presontation/screens/create_equetage_screen.dart';
// import 'package:devti_agro/features/nutrition/application/bloc/nutrition_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_refresh_error/refresh_data_in_screen.dart';

class EtiquetageScreen extends StatelessWidget {
  const EtiquetageScreen({super.key});

  void _openFilterSheet(BuildContext context) {
    showFilterBottomSheet(
      context: context,
      title: 'Filter by',
      filterOptions: ['Nom Ascending', 'Nom Descending', 'Quantite'],
      filterActions: {
        'Nom Ascending': () {
          BlocProvider.of<EtiquetageBloc>(context).add(const FilterEtiquetageEvent(filterType: 'nom', isAscending: true));
          context.pop();
        },
        'Nom Descending': () {
          BlocProvider.of<EtiquetageBloc>(context).add(const FilterEtiquetageEvent(filterType: 'nom', isAscending: false));
          context.pop();
        },
        'Quantite': () {
          BlocProvider.of<EtiquetageBloc>(context).add(const FilterEtiquetageEvent(filterType: 'quantite'));
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void onDateRangeSelected(DateTimeRange dateRange) {
      context.read<EtiquetageBloc>().add(FilterEtiquetageByDateRangeEvent(dateRange: dateRange));
    }

    return Scaffold(
      appBar: CustomAppbar(
        elevation: 1,
        title: "Etiquetage",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,
          size: 30,
        ),
        trailingAction: () {
          // GoRouter.of(context).pushNamed(AppRoutes.etiquetageCreate);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEquetage()),
          );
        },
      ),
      drawer: const CustomDrawer(currentRoute: "Etiquetage"),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<EtiquetageBloc>().add(RefreshEtiquetageEvent()); // Ensure this method is asynchronous
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(
                  onSearchChanged: (searchText) {
                    context.read<EtiquetageBloc>().add(SearchEtiquetageEvent(searchText: searchText));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomFilter(
                      filterAction: () => _openFilterSheet(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DateRangePicker(
                        onDateRangeSelected: onDateRangeSelected,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<EtiquetageBloc, EtiquetageState>(builder: (context, state) {
                if (state is LoadingEtiquetageState) {
                  return const LoadingWidget();
                } else if (state is LoadedEtiquetageState) {
                  final data = state.etiquetage;
                  if (data.isEmpty) {
                    return CustomDataIsEmpty(onPressed: () => context.read<EtiquetageBloc>().add(RefreshEtiquetageEvent()));
                  }
                  final List<List<String>> rowData = data.map((etiquetage) {
                    return [etiquetage.name, etiquetage.category, etiquetage.dateDDM.substring(2), etiquetage.dateDLC.substring(2)];
                  }).toList();

                  final List<String> headerTitles = ["nom", "category", "type", "date"];
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: CustomDataTable(
                      headerTitles: headerTitles,
                      rowsData: rowData,
                    ),
                  );
                } else if (state is ErrorEtiquetageState) {
                  return RefreshDataInScreen(
                    message: state.message,
                    onPressed: () {
                      context.read<EtiquetageBloc>().add(RefreshEtiquetageEvent());
                    },
                  );
                }
                return const LoadingWidget();
              })
            ],
          ),
        ),
      ),
    );
  }
}
