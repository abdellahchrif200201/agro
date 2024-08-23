
import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';




class Temperature extends StatelessWidget {
  const Temperature({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<List<String>> rowsData = [
      ["regi1", "45m", "10°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "50°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"1"],
      ["regi1", "45m", "27°C" ,"2"],
    ];

    final List<String> headerTitles = ["nom", "surface", "temperature" , "Nembre"];

    void _openFilterSheet(BuildContext context) {
      showFilterBottomSheet(
        context: context,
        title: 'Filter by',
        filterOptions: ['nom', 'surface'],
        filterActions: {
          'nom': () => print('Zone tapped'),
          'surface': () => print('Type tapped'),
        },
      );
    }

    return Scaffold(
      appBar: CustomAppbar(

        elvation: 1,
        title: "Temperature",
        trailingIcon: FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,size: 30,


        ),
        trailingAction: () {
          GoRouter.of(context).pushNamed(AppRoutes.etiquetageCreate);        },
      ),
      drawer: const CustomDrawer(currentRoute: "Temperature"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomSearchBar(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CustomFilter(filterAction: ()=> _openFilterSheet(context), ),
                  const SizedBox(width: 8),
                   Expanded(
                     child: DateRangePicker(onDateRangeSelected: (p0) => null,),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomDataTable(
                rowsData: rowsData,
                headerTitles: headerTitles,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
