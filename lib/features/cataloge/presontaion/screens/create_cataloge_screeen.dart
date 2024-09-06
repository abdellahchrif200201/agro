import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/features/Fournisseur/aplication/bloc/add_role_bloc/bloc/Fournisseur_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; // Fixed import path

class CreateCatalogeScreeen extends StatefulWidget {
  const CreateCatalogeScreeen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateCatalogeScreeenState createState() => _CreateCatalogeScreeenState();
}

class _CreateCatalogeScreeenState extends State<CreateCatalogeScreeen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surfaceController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  String? selectedZone;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "create cataloge",
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
              FormElement(
                hint: "Reference",
                label: "Reference",
                controller: nameController,
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "Désignation",
                label: "Désignation",
                controller: surfaceController,
              ),
              const SizedBox(height: 16.0),
              FormElement(
                hint: "Prix",
                label: "Prix",
                keyboardType: TextInputType.number,
                controller: temperatureController,
              ),
              const SizedBox(height: 16.0),
              FormElement(
                hint: "Quantite Unitaire",
                label: "Quantite Unitaire",
                controller: temperatureController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "Select Fournisseur",
                label: "Fournisseur",
                child: BlocBuilder<FournisseurBloc, FournisseurState>(
                  builder: (context, state) {
                    if (state is LoadingFournisseurState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("loading.."),
                            LoadingAnimationWidget.newtonCradle(
                              color: Color.fromARGB(255, 13, 200, 63),
                              size: 30,
                            ),
                          ],
                        ),
                      );
                    } else if (state is LoadedFournisseurState) {
                      final List<String> options = state.fournisseurs.map((zone) => zone.name).toList();

                      // Reset selectedZone if it is not in the options
                      if (selectedZone != null && !options.contains(selectedZone)) {
                        setState(() {
                          selectedZone = options.isNotEmpty ? options[0] : null;
                        });
                      }

                      return DropdownTwo(
                        hint: selectedZone ?? "Select Fournisseur",
                        dropDownItems: options,
                        onChanged: (value) {
                          setState(() {
                            selectedZone = value;
                          });
                        },
                      );
                    } else if (state is ErrorFournisseurState) {
                      return RefreshData(
                        onPressed: () => context.read<FournisseurBloc>().add(GetAllFournisseurEvent()),
                      );
                    }

                    return const Center(child: Text("loading ..."));
                  },
                ),
              ),
              const SizedBox(height: 50.0),
              CustomButton(
                text: "create cataloge",
                onPressed: () => print("test"),)
            ],
          ),
        ),
      ),
    );
  }
}
