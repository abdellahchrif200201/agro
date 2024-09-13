import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_is_empty/custom_data_is_empty.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_screen.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/loading_widget.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/chambre/presontaion/screens/CreateChambre.dart';
import 'package:devti_agro/features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:devti_agro/features/chambre/presontaion/service/delete_chambre_service.dart';
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
  late List<bool> isDeleting; // List to manage the loading state for each row

  @override
  void initState() {
    super.initState();
    filterHelper = ChambreFilterHelper(context);
    isDeleting = List.filled(0, false); // Initialize with empty list, will set length dynamically
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
                    final data = state.chambres;
                    if (data.isEmpty) {
                      return CustomDataIsEmpty(
                        onPressed: () {
                           context.read<ChambresBloc>().add(RefreshChambresEvent());
                        },
                      );
                    }
                    // Prepare the rows data
                    final List<List<String>> rowsData = data.map((chambre) {
                      return [
                        chambre.id.toString(), // Keep the ID for reference
                        chambre.name,
                        '${chambre.surface}',
                        '${chambre.temperature}°C'
                      ];
                    }).toList();

                    // Initialize isDeleting list with the correct length
                    isDeleting = List.filled(rowsData.length, false);

                    // Define the header titles (excluding ID)
                    final List<String> headerTitles = ["Nom", "Surface", "Température"];

                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        child: CustomDataTable(
                          rowsData: rowsData.map((row) => row.sublist(1)).toList(), // Exclude ID column for display

                          headerTitles: headerTitles,
                          onDeletePressed: (rowIndex) async {
                            print("object");
                            final id = rowsData[rowIndex][0];
                            int chambreId = int.parse(id);

                            setState(() {
                              isDeleting[rowIndex] = true; // Start loading for this row
                            });

                            await ChambreDeletionService(context).deleteChambre(chambreId);

                            setState(() {
                              isDeleting[rowIndex] = false; // Stop loading after delete operation
                            });
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
                          // allPage: state.chambres.first.lastPage ?? 1,
                          // pageNow: state.chambres.first.pageCurrent ?? 1,
                          // onPressNextPage: () {
                          //   setState(() {
                          //     final currentPage = state.chambres.first.pageFrom ?? 1;
                          //     final nextPage = currentPage + 1;
                          //     final totalPages = state.chambres.first.lastPage;

                          //     if (nextPage <= totalPages!) {
                          //       context.read<ChambresBloc>().add(GetAllChambresEvent(page: nextPage));
                          //     }
                          //   });
                          // },

                          // onPressPreviousPage: () {
                          //   setState(() {
                          //     final currentPage = state.chambres.first.pageFrom ?? 1;
                          //     if (currentPage > 1) {
                          //       final previousPage = currentPage - 1;
                          //       context.read<ChambresBloc>().add(GetAllChambresEvent(page: previousPage));
                          //     }
                          //   });
                          // },
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

  // Future<void> _deleteChambre(BuildContext context, int id) async {
  //   final deleteBloc = BlocProvider.of<AddDeleteUpdateChambreBloc>(context);

  //   deleteBloc.add(DeleteChambreEvent(chambreId: id));

  //   final state = await deleteBloc.stream.firstWhere(
  //     (state) => state is ErrorDeleteUpdateChambreState || state is MessageDeleteUpdateChambreState,
  //   );

  //   if (state is MessageDeleteUpdateChambreState) {
  //     if (state.message == DELETE_SUCCESS_MESSAGE) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Chambre deleted successfully')),
  //       );
  //       BlocProvider.of<ChambresBloc>(context).add(const FilterChambresEvent(filterType: 'nom', isAscending: true));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to delete chambre')),
  //       );
  //     }
  //   } else if (state is ErrorDeleteUpdateChambreState) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred')),
  //     );
  //   }
  // }
}
