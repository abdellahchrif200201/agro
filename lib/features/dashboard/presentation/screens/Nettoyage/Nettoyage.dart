import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'Nettoyage_widgets/Nettoyage_card.dart';


class Nettoyage extends StatefulWidget {
  const Nettoyage({super.key});

  @override
  State<Nettoyage> createState() => _NettoyageState();
}

class _NettoyageState extends State<Nettoyage> {
  void _openFilterSheet(BuildContext context) {
    showFilterBottomSheet(
      context: context,
      title: 'Filter by',
      filterOptions: ['Zone', 'Type', 'Category'],
      filterActions: {
        'Zone': () => print('Zone tapped'),
        'Type': () => print('Type tapped'),
        'Category': () => print('Category tapped'),
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        elvation: 1,
        title: "Nettoyage",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,size: 30,
        ),
        trailingAction: () {
          GoRouter.of(context).pushNamed(AppRoutes.etiquetageCreate);
        },
      ),
      drawer: const CustomDrawer(
        currentRoute: "Nettoyage",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomSearchBar(
                hintText: "Filter les plan...",
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
                     child: DateRangePicker(onDateRangeSelected: (p0) => null,),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // Number of Nettoyage_Card widgets
              itemBuilder: (BuildContext context, int index) {
                return const  NettoyageCard(title: 'test',plan: ["plan"],date: "200132",);
              },
            ),
          ],
        ),
      ),
    );
  }
}
