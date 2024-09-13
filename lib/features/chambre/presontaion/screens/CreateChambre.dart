import 'package:devti_agro/core/widgets/Custom_form_element/text_field_widget.dart';
import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';
import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
import 'package:devti_agro/features/chambre/presontaion/service/chambre_service.dart';
import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/widgets/Custom_dropdown/dorp_down_two.dart';
import '../../../../core/widgets/custom_button/custom_btn.dart';
import '../../../../core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import '../../../zone/aplication/bloc/zone/bloc/zone_bloc.dart';

class CreateChambre extends StatefulWidget {
  final Chambre? chambre;
  CreateChambre({this.chambre});

  @override
  _CreateChambreState createState() => _CreateChambreState();
}

class _CreateChambreState extends State<CreateChambre> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surfaceController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final ChambreService chambreService = ChambreService();

  String? selectedZone;
  bool isRun = false;

  @override
  void initState() {
    super.initState();

    if (widget.chambre != null) {
      nameController.text = widget.chambre!.name;
      surfaceController.text = widget.chambre!.surface.toString();
      temperatureController.text = widget.chambre!.temperature.toString();
      selectedZone = widget.chambre!.zoneName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Chambre",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextFieldWidget(
                hintText: "Nom",
                controller: nameController,
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                hintText: "Surface",
                controller: surfaceController,
              ),
              const SizedBox(height: 16.0),
              TextFieldWidget(
                hintText: "Temperature",
                controller: temperatureController,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<ZoneBloc, ZoneState>(
                builder: (context, state) {
                  if (state is LoadingZoneState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("loading.."),
                          LoadingAnimationWidget.newtonCradle(
                            color: const Color.fromARGB(255, 13, 200, 63),
                            size: 30,
                          ),
                        ],
                      ),
                    );
                  } else if (state is LoadedZoneState) {
                    final List<String> options = state.zone.map((zone) => zone.name).toList();

                    if (selectedZone != null && !options.contains(selectedZone)) {
                      setState(() {
                        selectedZone = options.isNotEmpty ? options[0] : null;
                      });
                    }

                    return DropdownTwo(
                      border: true,
                      hint: selectedZone ?? "Select zone",
                      dropDownItems: options,
                      onChanged: (value) {
                        setState(() {
                          selectedZone = value;
                        });
                      },
                    );
                  } else if (state is ErrorZoneState) {
                    return RefreshData(
                      onPressed: () => context.read<ZoneBloc>().add(const GetAllZoneEvent(idEntreprise: 1)),
                    );
                  }

                  return const Center(child: Text("loading ..."));
                },
              ),
              const SizedBox(height: 50.0),
              CustomButton(
                text: widget.chambre != null ? S.of(context).edit : S.of(context).save,
                isRun: isRun,
                onPressed: () {
                  final name = nameController.text;
                  final surface = double.tryParse(surfaceController.text) ?? 0.0;
                  final temperature = double.tryParse(temperatureController.text) ?? 0.0;

                  if (name.isEmpty || surface <= 0 || temperature <= 0) {
                    setState(() {
                      isRun = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill out all fields correctly')),
                    );
                    return;
                  }

                  setState(() {
                    isRun = true;
                  });

                  if (widget.chambre == null) {
                    chambreService.addChambre(
                      context,
                      ChambreModel(
                        name: name,
                        surface: surface,
                        temperature: temperature,
                        entrepriseICE: 4531847,
                        zoneId: 1,
                      ),
                      (isRunning) => setState(() {
                        isRun = isRunning;
                      }),
                    );
                  } else {
                    chambreService.updateChambre(
                      context,
                      ChambreModel(
                        id: widget.chambre!.id,
                        name: name,
                        surface: surface,
                        temperature: temperature,
                        zoneId: widget.chambre!.zoneId,
                      ),
                      (isRunning) => setState(() {
                        isRun = isRunning;
                      }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
// import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
// import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
// import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
// import 'package:devti_agro/features/chambre/application/bloc/create_chambre_bloc/add_chambre_bloc.dart';
// import 'package:devti_agro/features/chambre/application/bloc/delete_update_chambre/delete_update_chambre_bloc.dart';
// import 'package:devti_agro/features/chambre/application/bloc/get_chambres_bloc/chambres_bloc.dart';
// import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';
// import 'package:devti_agro/features/chambre/domain/entities/Chambre.dart';
// import 'package:devti_agro/features/zone/aplication/bloc/zone/bloc/zone_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// import '../../../../core/strings/failures.dart'; // Fixed import path

// class CreateChambre extends StatefulWidget {
//   final Chambre? chambre;
//   CreateChambre({this.chambre});

//   @override
//   _CreateChambreState createState() => _CreateChambreState();
// }

// class _CreateChambreState extends State<CreateChambre> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController surfaceController = TextEditingController();
//   final TextEditingController temperatureController = TextEditingController();

//   String? selectedZone;
//   bool isRun = false;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.chambre != null) {
//       nameController.text = widget.chambre!.name;
//       surfaceController.text = widget.chambre!.surface.toString();
//       temperatureController.text = widget.chambre!.temperature.toString();
//       selectedZone = widget.chambre!.zoneName;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "create chambre",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Ionicons.chevron_back_outline,
//             color: Theme.of(context).iconTheme.color,
//           ),
//         ),
//         leadingWidth: 80,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Nom",
//                 label: "Nom",
//                 controller: nameController,
//               ),
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Select zone",
//                 label: "Zone",
//                 child: BlocBuilder<ZoneBloc, ZoneState>(
//                   builder: (context, state) {
//                     if (state is LoadingZoneState) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const Text("loading.."),
//                             LoadingAnimationWidget.newtonCradle(
//                               color: const Color.fromARGB(255, 13, 200, 63),
//                               size: 30,
//                             ),
//                           ],
//                         ),
//                       );
//                     } else if (state is LoadedZoneState) {
//                       final List<String> options = state.zone.map((zone) => zone.name).toList();

//                       // Reset selectedZone if it is not in the options
//                       if (selectedZone != null && !options.contains(selectedZone)) {
//                         setState(() {
//                           selectedZone = options.isNotEmpty ? options[0] : null;
//                         });
//                       }

//                       return DropdownTwo(
//                         hint: selectedZone ?? "Select zone",
//                         dropDownItems: options,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedZone = value;
//                           });
//                         },
//                       );
//                     } else if (state is ErrorZoneState) {
//                       return RefreshData(
//                         onPressed: () => context.read<ZoneBloc>().add(const GetAllZoneEvent(idEntreprise: 1)),
//                       );
//                     }

//                     return const Center(child: Text("loading ..."));
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Surface",
//                 label: "Surface",
//                 controller: surfaceController,
//               ),
//               const SizedBox(height: 16.0),
//               FormElement(
//                 hint: "Temperature",
//                 label: "Temperature",
//                 controller: temperatureController,
//               ),
//               const SizedBox(height: 50.0),
//               CustomButton(
//                 text: widget.chambre != null ? "update chambre" : "create chambre",
//                 isRun: isRun,
//                 onPressed: () {
//                   final name = nameController.text;
//                   final surface = double.tryParse(surfaceController.text) ?? 0.0;
//                   final temperature = double.tryParse(temperatureController.text) ?? 0.0;

//                   if (name.isEmpty || surface <= 0 || temperature <= 0) {
//                     setState(() {
//                       isRun = false;
//                     });
//                     // Show error message or validation
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Please fill out all fields correctly')),
//                     );
//                     return;
//                   }
//                   if (widget.chambre == null) {
//                     setState(() {
//                       isRun = true;
//                     });
//                     _addChambre(
//                         context,
//                         ChambreModel(
//                           name: name,
//                           surface: surface,
//                           temperature: temperature,
//                           entrepriseICE: 4531847,
//                           zoneId: 1,
//                         ));
//                   } else {
//                     setState(() {
//                       isRun = true;
//                     });
//                     _updateChambre(
//                         context,
//                         ChambreModel(
//                           id: widget.chambre!.id,
//                           name: name,
//                           surface: surface,
//                           temperature: temperature,
//                           zoneId: widget.chambre!.zoneId,
//                         ));
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _updateChambre(BuildContext context, ChambreModel chambreModel) async {
//     final bloc = BlocProvider.of<AddDeleteUpdateChambreBloc>(context);

//     bloc.add(UpdateChambreEvent(chambre: chambreModel));

//     final state = await bloc.stream.firstWhere(
//       (state) => state is ErrorDeleteUpdateChambreState || state is MessageDeleteUpdateChambreState,
//     );

//     if (state is MessageDeleteUpdateChambreState && state.message == UPDATE_SUCCESS_MESSAGE) {
//       setState(() {
//         isRun = false;
//       });
//       showTopSnackBar(
//         Overlay.of(context),
//         const CustomSnackBar.success(
//           message: "the chambre is updated",
//         ),
//       );
//       context.read<ChambresBloc>().add(RefreshChambresEvent());
//       print("lmard");
//     } else {
//       setState(() {
//         isRun = false;
//       });
//       // Handle error
//       showTopSnackBar(
//         Overlay.of(context),
//         const CustomSnackBar.error(
//           message: "the chambre is not updated",
//         ),
//       );
//     }
//   }

//   Future<void> _addChambre(BuildContext context, ChambreModel chambreModel) async {
//     final bloc = BlocProvider.of<AddChambreBloc>(context);

//     bloc.add(AddChambreButtonPressed(chambre: chambreModel));

//     final state = await bloc.stream.firstWhere(
//       (state) => state is AddChambreFailure || state is AddChambreSuccess,
//     );

//     if (state is AddChambreSuccess /* && state.message == UPDATE_SUCCESS_MESSAGE*/) {
//       setState(() {
//         isRun = false;
//       });
//       showTopSnackBar(
//         Overlay.of(context),
//         const CustomSnackBar.success(
//           message: "the chambre is updated",
//         ),
//       );
//       // context.read<ChambresBloc>().add(RefreshChambresEvent());
//       print("lmard");
//     } else {
//       setState(() {
//         isRun = false;
//       });
//       // Handle error
//       showTopSnackBar(
//         Overlay.of(context),
//         const CustomSnackBar.error(
//           message: "the chambre is not updated",
//         ),
//       );
//     }
//   }
// }
