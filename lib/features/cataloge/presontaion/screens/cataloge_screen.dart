import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_data_table/custom_data_table.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';

import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/cataloge/presontaion/screens/create_cataloge_screeen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CatalogeScreen extends StatelessWidget {
  const CatalogeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<List<String>> rowsData = [
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
      ["3000", "télEst116", "téléphone", "15", "Estrella Terry", "100"],
    ];

    final List<String> headerTitles = ["code", "Reference", "Désignation", "Quantite Unitaire", 'Fournisseur', 'Prix'];

    return Scaffold(
      appBar: CustomAppbar(
        elevation: 1,
        title: "Cataloge",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,
          size: 30,
        ),
        trailingAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCatalogeScreeen()),
          );
        },
      ),
      drawer: const CustomDrawer(currentRoute: "Cataloge"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomSearchBar(),
            ),
            // Container(
            //     margin: EdgeInsets.all(8.0),
            //     padding: const EdgeInsets.all(8.0),
            //     decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
            //     child: Text(
            //       "Export",
            //       style: TextStyle(color: Colors.white),
            //     )),
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
