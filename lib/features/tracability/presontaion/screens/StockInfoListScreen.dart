import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';
import 'package:devti_agro/features/tracability/presontaion/screens/colieData.dart';
import 'package:devti_agro/features/tracability/presontaion/widgets/ProductTileWidget.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum ColieType { In, Out, Retour }

class StockInfoListScreen extends StatelessWidget {
  StockInfoListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Traceability traking".tr,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: CustomDrawer(currentRoute: "Tracbalite"),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward),
                        SizedBox(width: 5),
                        Text('In'.tr),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward),
                        SizedBox(width: 5),
                        Text('Out'.tr),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.loop),
                        SizedBox(width: 5),
                        Text('Returned'.tr),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildTabContent(context, colieType: ColieType.In),
              buildTabContent(context, colieType: ColieType.Out),
              buildTabContent(context, colieType: ColieType.Retour),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContent(BuildContext context, {ColieType colieType = ColieType.In}) {
    List<ColieData> colieList = [
      ColieData(
        id: 1,
        referenceColie: 'REF123',
        idUser: 1,
        etat: 'In',
        statut: 'Pending',
        raison: 'None',
        idFournisseur: 1,
        idDestinataire: 1,
        quantiteApresTraitement: 100,
        quantiteAvantTraitement: 150,
        quantiteRetour: 0,
        quantiteSortie: 50,
        motif: 'Processing',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        prix: 250.0,
        destinataire: User(id: 1, name: 'John Doe', entrepriseId: 1),
        fournisseur: Fournisseur(id: 1, name: 'Acme Corp', email: "test"),
      ),
      ColieData(
        id: 2,
        referenceColie: 'REF124',
        idUser: 2,
        etat: 'Out',
        statut: 'Completed',
        raison: 'Delivered',
        idFournisseur: 2,
        idDestinataire: 2,
        quantiteApresTraitement: 200,
        quantiteAvantTraitement: 250,
        quantiteRetour: 0,
        quantiteSortie: 50,
        motif: 'Delivery',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        prix: 500.0,
        destinataire: User(id: 2, name: 'Jane Smith', entrepriseId: 1),
        fournisseur: Fournisseur(id: 2, name: 'Global Supplies', email: "te"),
      ),
      ColieData(
        id: 3,
        referenceColie: 'REF124',
        idUser: 2,
        etat: 'In',
        statut: 'Completed',
        raison: 'Delivered',
        idFournisseur: 2,
        idDestinataire: 2,
        quantiteApresTraitement: 200,
        quantiteAvantTraitement: 250,
        quantiteRetour: 0,
        quantiteSortie: 50,
        motif: 'Delivery',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        prix: 500.0,
        destinataire: User(id: 2, name: 'Jane Smith', entrepriseId: 1),
        fournisseur: Fournisseur(id: 2, name: 'Global Supplies', email: "abdou"),
      ),
      ColieData(
        id: 3,
        referenceColie: 'REF125',
        idUser: 3,
        etat: 'Retour',
        statut: 'Returned',
        raison: 'Defective',
        idFournisseur: 3,
        idDestinataire: 3,
        quantiteApresTraitement: 50,
        quantiteAvantTraitement: 100,
        quantiteRetour: 50,
        quantiteSortie: 0,
        motif: 'Return Processed',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        prix: 300.0,
        destinataire: User(id: 3, name: 'Alice Johnson', entrepriseId: 1),
        fournisseur: Fournisseur(id: 3, name: 'Tech World', email: "testts"),
      ),
    ];

    List<ColieData> getColies() {
      late List<ColieData> colies;
      switch (colieType) {
        case ColieType.In:
          colies = colieList.where((data) => data.etat == "In").toList();
          break;

        case ColieType.Out:
          colies = colieList.where((data) => data.etat == "Out").toList();
          break;

        case ColieType.Retour:
          colies = colieList.where((data) => data.etat == "Retour").toList();
          break;
        default:
          colies = [];
      }
      return colies;
    }

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${getColies().length} ${'Products'.tr}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 129, 129, 129),
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              reverse: true,
              itemCount: getColies().length,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                ColieData colieDataItem = getColies()[index];
                var outputFormat = DateFormat('dd MMMM, yyyy (hh:mm)', Intl.getCurrentLocale());
                var outputDate = outputFormat.format(colieDataItem.createdAt ?? DateTime.now());
                return ProductTileWidget(
                  fromSource: "suiviv-de-tracabiliti",
                  colieDataItem: colieDataItem,
                  outputDate: outputDate,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
