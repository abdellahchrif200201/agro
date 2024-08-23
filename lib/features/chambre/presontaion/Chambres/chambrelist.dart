// import 'package:devti_agro/features/dashboard/presentation/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
// import 'package:flutter/material.dart';
// import 'package:devti_agro/features/dashboard/domain/entities/chambre/Chambre.dart';

// class ChambreList extends StatelessWidget {
//   final List<Chambre> chambres;

//   const ChambreList({super.key, required this.chambres});

//   final List<List<String>> rowsData = [
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],
//       ["user1", "100.0", "27°C" ],

//     ];

//     final List<String> headerTitles = ["nom", "surface", "temperature" ];

    

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CustomSearchBar(),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   CustomFilter(filterAction: ()=> _openFilterSheet(context), ),
//                   const SizedBox(width: 8),
//                   const Expanded(
//                     child: DateRangePicker(),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.sizeOf(context).width,
//               child: CustomDataTable(
//                 rowsData: rowsData,
//                 headerTitles: headerTitles,
//               ),
//             ),
//           ],
//         ),
//   }
// }
