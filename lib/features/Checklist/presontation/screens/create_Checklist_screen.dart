import 'package:devti_agro/core/widgets/Custom_dropdown/DropDown.dart';
import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/features/user/aplication/bloc/add_role_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateChecklist extends StatefulWidget {
  @override
  _CreateChecklistState createState() => _CreateChecklistState();
}

class _CreateChecklistState extends State<CreateChecklist> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "create check list",
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text(
              //   'Infos générales',
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              const SizedBox(height: 16),
              const FormElement(
                hint: "Titre",
                label: "Titre",
              ),
              const SizedBox(height: 16),
              const FormElement(
                hint: "Description",
                label: "Description",
                maxLines: 5, // To make the input larger
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "Select date",
                label: "Date",
                child: TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    hintText: "Select date", // Add hint text here
                    hintStyle: TextStyle(color: Colors.grey), // Optional: Style the hint text
                    border: InputBorder.none, // Keep the border removed
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              FormElement(
                hint: "Select user",
                label: "user",
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is LoadingUserState) {
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
                    } else if (state is LoadedUserState) {
                      final List<String> options = state.users.map((zone) => zone.name).toList();

                      // Reset selectedUser if it is not in the options
                      if (selectedUser != null && !options.contains(selectedUser)) {
                        setState(() {
                          selectedUser = options.isNotEmpty ? options[0] : null;
                        });
                      }

                      return DropdownTwo(
                        hint: "Select user",
                        dropDownItems: options,
                        onChanged: (value) {
                          setState(() {
                            selectedUser = value;
                          });
                        },
                      );
                    } else if (state is ErrorUserState) {
                      return RefreshData(
                        onPressed: () => context.read<UserBloc>().add(GetAllUserEvent()),
                      );
                    }

                    return const Center(child: Text("loading ..."));
                  },
                ),
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "hint",
                label: "statut",
                child: Container(
                  width: double.infinity,
                  child: const Dropdown(
                    dropDownItem: ["urgeent", "zone3"],
                    hint: "Select zone",
                    // label: "Zone",
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // const FormElement(
              //   hint: "Chambre",
              //   label: "Chambre",
              // ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () {
                  print("object");
                },
                text: "save",
              )
            ],
          ),
        ),
      ),
    );
  }
}
