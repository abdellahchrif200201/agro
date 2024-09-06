import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_screen.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/loading_widget.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/chambre/application/bloc/delete_update_chambre/delete_update_chambre_bloc.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/CreateChambre.dart';
import 'package:devti_agro/features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:devti_agro/features/chambre/presontaion/widgets/chambre_filter_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChambreScreen extends StatefulWidget {
  const ChambreScreen({super.key});

  @override
  State<ChambreScreen> createState() => _ChambreScreenState();
}

class _ChambreScreenState extends State<ChambreScreen> {
  late ChambreFilterHelper filterHelper;

  @override
  void initState() {
    super.initState();
    filterHelper = ChambreFilterHelper(context);
  }

  @override
  Widget build(BuildContext context) {
    void onDateRangeSelected(DateTimeRange dateRange) {
      context.read<ChambresBloc>().add(FilterChambresByDateRange(dateRange: dateRange));
    }

    return Scaffold(
      appBar: CustomAppbar(
        isShowLogin: false,
        elevation: 1,
        title: "Chambres",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,
          size: 30,
        ),
        trailingAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateChambre()),
          );
        },
      ),
      drawer: const CustomDrawer(currentRoute: "Chambres"),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ChambresBloc>().add(RefreshChambresEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(
                  onSearchChanged: (searchText) {
                    context.read<ChambresBloc>().add(SearchChambresEvent(searchText));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomFilter(
                      filterAction: () => filterHelper.openFilterSheet(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DateRangePicker(
                        onDateRangeSelected: onDateRangeSelected,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<ChambresBloc, ChambresState>(
                builder: (context, state) {
                  if (state is LoadingChambresState) {
                    return const LoadingWidget();
                  } else if (state is LoadedChambresState) {
                    // Prepare the rows data
                    final List<List<String>> rowsData = state.chambres.map((chambre) {
                      return [
                        chambre.id.toString(), // Keep the ID for reference
                        chambre.name,
                        '${chambre.surface}',
                        '${chambre.temperature}°C'
                      ];
                    }).toList();

                    // Define the header titles (excluding ID)
                    final List<String> headerTitles = ["Nom", "Surface", "Température"];

                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        child: CustomDataTable(
                          rowsData: rowsData.map((row) => row.sublist(1)).toList(), // Exclude ID column for display

                          headerTitles: headerTitles,
                          onDeletePressed: (rowIndex) {
                            final id = rowsData[rowIndex][0];
                            int chambreId = int.parse(id);
                            _deleteChambre(context, chambreId);
                          },
                          onEditPressed: (rowIndex) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateChambre(
                                        chambre: state.chambres[rowIndex],
                                      )),
                            );
                          },
                          // initialPage: state.chambres.first.pageFrom ?? 0,
                          allPage: state.chambres.first.lastPage ?? 1,
                          pageNow: state.chambres.first.pageCurrent ?? 1,
                          onPressNextPage: () {
                            setState(() {
                              // Check if state.chambres is not empty and pageFrom is valid
                              final currentPage = state.chambres.isNotEmpty ? state.chambres.first.pageFrom ?? 1 : 1;

                              // Calculate the next page
                              final nextPage = currentPage + 1;

                              // Check if nextPage is within the valid range
                              final totalPages = state.chambres.first.lastPage; // Replace with the actual way to get total pages

                              if (nextPage <= totalPages!) {
                                // Dispatch the event to load the next page
                                context.read<ChambresBloc>().add(GetAllChambresEvent(page: nextPage));
                              } else {
                                // Optionally show a message or handle the end of pages
                                // e.g., showSnackbar('You are already on the last page.');
                              }
                            });
                          },

                          onPressPreviousPage: () {
                            setState(() {
                              // Ensure that currentPage is initialized and valid
                              final currentPage = state.chambres.first.lastPage ?? 0;
                              if (currentPage > 1) {
                                final nextPage = currentPage - 1;

                                // Dispatch the event to load the previous page
                                context.read<ChambresBloc>().add(GetAllChambresEvent(page: nextPage));
                              }
                            });
                          },
                        ),
                      ),
                    );
                  } else if (state is ErrorChambresState) {
                    return RefreshDataInScreen(
                      onPressed: () => context.read<ChambresBloc>().add(RefreshChambresEvent()),
                      message: state.message,
                    );
                  }
                  return const LoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteChambre(BuildContext context, int id) async {
    final deleteBloc = BlocProvider.of<AddDeleteUpdateChambreBloc>(context);

    // Add delete user event
    deleteBloc.add(DeleteChambreEvent(chambreId: id));

    // Listen for state changes
    final state = await deleteBloc.stream.firstWhere(
      (state) => state is ErrorDeleteUpdateChambreState || state is MessageDeleteUpdateChambreState,
    );

    if (state is MessageDeleteUpdateChambreState) {
      // Check if message contains success confirmation
      if (state.message == DELETE_SUCCESS_MESSAGE) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('chambre deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete checklist')),
        );
      }
    } else if (state is ErrorDeleteUpdateChambreState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }
}
