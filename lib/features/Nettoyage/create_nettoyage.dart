import 'package:devti_agro/core/widgets/Custom_dropdown/DropDown.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:flutter/material.dart';

class CreateNettoyage extends StatefulWidget {
  @override
  _CreateNettoyageState createState() => _CreateNettoyageState();
}

class _CreateNettoyageState extends State<CreateNettoyage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Nettoyage'),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Infos générales',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              const FormElement(
                hint: "nom",
                label: "nom",
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
                hint: "hint",
                label: "Affectation utilisateur",
                child: Container(
                  width: double.infinity,
                  child: const Dropdown(
                    dropDownItem: ["User 1", "User 2", "User 3"], // Replace with actual user options
                    hint: "Select user",
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "chambre",
                label: "chambre",
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
              FormElement(
                hint: "zone",
                label: "zone",
                child: Container(
                  width: double.infinity,
                  child: const Dropdown(
                    dropDownItem: ["urgeent", "zone3"],
                    hint: "Select zone",
                    // label: "Zone",
                  ),
                ),
              ),
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
