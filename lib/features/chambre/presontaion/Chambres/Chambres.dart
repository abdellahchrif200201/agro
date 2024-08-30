import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/loading_widget.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/CreateChambre.dart';
import 'package:devti_agro/features/chambre/presontaion/bloc/get_chambres_bloc/chambres_bloc.dart';
import 'package:devti_agro/features/chambre/presontaion/widgets/chambre_filter_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChambreWidget extends StatefulWidget {
  const ChambreWidget({super.key});

  @override
  State<ChambreWidget> createState() => _ChambreWidgetState();
}

class _ChambreWidgetState extends State<ChambreWidget> {
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
                      filterAction: () => filterHelper.openFilterSheet(), // Use the helper class
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
                    final List<List<String>> rowsData = state.chambres.map((chambre) {
                      return [chambre.name, '${chambre.surface}', '${chambre.temperature}°C'];
                    }).toList();

                    final List<String> headerTitles = ["nom", "surface", "temperature"];

                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        child: CustomDataTable(
                          rowsData: rowsData,
                          headerTitles: headerTitles,
                        ),
                      ),
                    );
                  } else if (state is ErrorChambresState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
                  return const LoadingWidget(); // Return a default loading widget if none of the other states match
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
