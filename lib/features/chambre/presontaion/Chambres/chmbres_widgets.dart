

// import 'package:devti_agro/core/route/routes.dart';
// import 'package:devti_agro/core/widgets/loading_widget.dart';
// import 'package:devti_agro/features/dashboard/presentation/bloc/chambres/chambres_bloc.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/Custom_FilterBottomSheet/FilterBottomSheet.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/custom_appbar/Custom_appbar.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/custom_data_table/custom_data_table.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/custom_drawer/custom_drawer.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/custom_filter_button/CustomFilter.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/date_range_picker/date_range_picker.dart';
// import 'package:devti_agro/features/dashboard/presentation/widgets/search_bar.dart/custom_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';import 'package:go_router/go_router.dart';



// class Chambres extends StatelessWidget {
//   const Chambres({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Sample data
//     final List<List<String>> rowsData = [
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

//     void _openFilterSheet(BuildContext context) {
//       showFilterBottomSheet(
//         context: context,
//         title: 'Filter by',
//         filterOptions: ['nom', 'surface'],
//         filterActions: {
//           'nom': () => print('Zone tapped'),
//           'surface': () => print('Type tapped'),
//         },
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppbar(
//         elvation: 1,
//         title: "Chambres",
//         trailingIcon: const FaIcon(
//           FontAwesomeIcons.circlePlus,
//           color: Colors.black,size: 30,


//         ),
//         trailingAction: () {
//           GoRouter.of(context).pushNamed(AppRoutes.etiquetageCreate);
//         },
//       ),
//       drawer: const CustomDrawer(currentRoute: "Chambres"),
//       body: SingleChildScrollView(
//         child: BlocBuilder<ChambresBloc , ChambresState>(
//           builder: (context, state) {
//             if(state is LoadedChambresState) {
//               return LoadingWidget();
//             }else if(state is LoadedChambresState) {
//               return ChambresListWidgets(chambres : state.chambres);
//             }else if(state is ErrorChambresState){
//               return Text(state.message);
//             }
//             return LoadingWidget();
//     }

//         ),




        
//       ),
//     );
//   }
// }
