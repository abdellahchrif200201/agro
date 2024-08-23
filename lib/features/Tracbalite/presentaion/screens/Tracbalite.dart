import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/bloc/tracabilte_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/loading_widget.dart';

class Tracbalite extends StatelessWidget {
  const Tracbalite({super.key});

    void _openFilterSheet(BuildContext context) {
      showFilterBottomSheet(
        context: context,
        title: 'Filter by',
        filterOptions: ['Nom Ascending', 'Nom Descending', 'Quantite'],
        filterActions: {
          'Nom Ascending': () {
            BlocProvider.of<TracabilteBloc>(context).add(const FilterTracabilteEvent(filterType: 'nom', isAscending: true));
            context.pop();
          },
          'Nom Descending': () {
            BlocProvider.of<TracabilteBloc>(context).add(const FilterTracabilteEvent(filterType: 'nom', isAscending: false));
            context.pop();
          },
          'Quantite': () {
            BlocProvider.of<TracabilteBloc>(context).add(const FilterTracabilteEvent(filterType: 'quantite'));
            context.pop();
          }
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    // Sample data

    void onDateRangeSelected(DateTimeRange dateRange) {
      context.read<TracabilteBloc>().add(FilterTracabilteByDateRangeEvent(dateRange: dateRange));
    }

    return Scaffold(
      appBar: CustomAppbar(
        elvation: 1,
        title: "Tracbalite",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,
          size: 30,
        ),
        scIcon: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all()),
            child: const Icon(
              Icons.calendar_month_outlined,
              size: 20,
            )),
        trailingAction: () {
          GoRouter.of(context).pushNamed(AppRoutes.traceabilityCreate);
        },
      ),
      drawer: const CustomDrawer(currentRoute: "Tracbalite"),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TracabilteBloc>().add(RefreshTracabilteEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(
                  onSearchChanged: (searchText) {
                    context.read<TracabilteBloc>().add(SearchTracabilteEvent(searchText));
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
              const SizedBox(height: 40),
              BlocBuilder<TracabilteBloc, TracabilteState>(
                builder: (context, state) {
                  if (state is LoadingTracabiliteState) {
                    return const LoadingWidget();
                  } else if (state is LoadedTracabiliteState) {
                    final List<List<String>> rowData = state.tracabilte.map(
                      (tracabilite) {
                        return [
                          tracabilite.name, // Name of the item
                          tracabilite.unite, // Unite
                          tracabilite.quantite.toString(), // Quantity as a String
                          tracabilite.nutrition, // Date DLC from Nutrition
                        ];
                      },
                    ).toList();

                    final List<String> headerTitles = ["Nom", "Unite", "Quantite", "nutrition"];
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CustomDataTable(
                        headerTitles: headerTitles,
                        rowsData: rowData,
                      ),
                    );
                  } else if (state is ErrorTracabilteState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const LoadingWidget();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
