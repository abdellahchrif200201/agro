import 'dart:io';

import 'package:devti_agro/core/widgets/Custom_dropdown/DropDown.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/date_range_picker/SingleDatePicker.dart';
import 'package:devti_agro/features/Etiquetage/presontation/widgets/InformationOptionel.dart';
import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEquetage extends StatefulWidget {
  const CreateEquetage({super.key});

  @override
  _CreateEquetageState createState() => _CreateEquetageState();
}

class _CreateEquetageState extends State<CreateEquetage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles = []; // Change to a list to support multiple images

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage(); // Use pickMultiImage to select multiple images
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFAFAFA),
        elevation: 2,
        title: const Text(
          'Etiqueteuse',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this to the desired color
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Infos générales',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 4.0),
                      Text(
                        "Date",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const LocalContainer(child: SingleDatePicker()),
                ],
              ),
              const SizedBox(height: 16),
              Dropdown(
                dropDownItem: ["fait", "overt"],
                hint: "select your type",
                label: "type",
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(height: 16),
              const Text(
                'Produit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8.0),
              const FormElement(
                hint: "nom de produit",
                label: "Nom",
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xffedede9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Add images",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _imageFiles!.isEmpty
                  ? Text(
                      'No images selected.',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _imageFiles!.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(_imageFiles![index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
              const SizedBox(height: 16.0),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(height: 16.0),
              const Informationoptionel(),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.inbox, color: Colors.white),
                            Text(
                              'Imprinter',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: const Color(0xffedede9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'save',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
