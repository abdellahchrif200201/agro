import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_is_empty/custom_data_is_empty.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_screen.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/nutrition/application/bloc/nutrition_bloc.dart';
import 'package:devti_agro/features/nutrition/presentaion/screens/create_tracbalite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/loading_widget.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  // void _openFilterSheet(BuildContext context) {
  //   showFilterBottomSheet(
  //     context: context,
  //     title: 'Filter by',
  //     filterOptions: ['Nom Ascending', 'Nom Descending', 'Quantite'],
  //     filterActions: {
  //       'Nom Ascending': () {
  //         BlocProvider.of<NutritionBloc>(context).add(const FilterNutristionEvent(filterType: 'nom', isAscending: true));
  //         context.pop();
  //       },
  //       'Nom Descending': () {
  //         BlocProvider.of<NutristionBloc>(context).add(const FilterNutristionEvent(filterType: 'nom', isAscending: false));
  //         context.pop();
  //       },
  //       'Quantite': () {
  //         BlocProvider.of<NutristionBloc>(context).add(const FilterNutristionEvent(filterType: 'quantite'));
  //         context.pop();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // Sample data

    // void onDateRangeSelected(DateTimeRange dateRange) {
    //   context.read<NutristionBloc>().add(FilterNutristionByDateRangeEvent(dateRange: dateRange));
    // }

    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Scaffold(
      appBar: CustomAppbar(
        elevation: 1,
        title: "Nutrition",
        trailingIcon: FaIcon(
          FontAwesomeIcons.circlePlus,
          color: themeBloc ? Colors.white : Colors.black,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTracbaliteScreen()),
          );
        },
      ),
      drawer: const CustomDrawer(currentRoute: "Nutrition"),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NutritionBloc>().add(RefreshNutritionEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(
                    // onSearchChanged: (searchText) {
                    //   context.read<NutritionBloc>().add(SearchNutritionEvent(searchText));
                    // },
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomFilter(
                      filterAction: () => print(10),
                    ),
                    const SizedBox(width: 8),
                    // Expanded(
                    //   child: DateRangePicker(
                    //     onDateRangeSelected: ,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              BlocBuilder<NutritionBloc, NutritionState>(
                builder: (context, state) {
                  if (state is LoadingNutritionState) {
                    return const LoadingWidget();
                  } else if (state is LoadedNutritionState) {
                    final data = state.nutrition;
                    if (data.isEmpty) {
                      return CustomDataIsEmpty(onPressed: () => context.read<NutritionBloc>().add(RefreshNutritionEvent()));
                    }
                    final List<List<String>> rowData = data.map(
                      (nutrition) {
                        return [
                          nutrition.name, // Name of the item
                          nutrition.name, // Unite
                          nutrition.barCode.toString(), // Quantity as a String
                          nutrition.category, // Date DLC from Nutrition
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
                  } else if (state is ErrorNutritionState) {
                    return RefreshDataInScreen(
                      message: state.message,
                      onPressed: () {
                        context.read<NutritionBloc>().add(RefreshNutritionEvent());
                      },
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
