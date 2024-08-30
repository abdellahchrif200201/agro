import 'dart:io';

import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/edit_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(60, 50),
                elevation: 3,
              ),
              icon: Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage, // Trigger image picker on tap
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            image: _image == null
                                ? const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/avatar.png",
                                    ),
                                    fit: BoxFit.cover)
                                : DecorationImage(image: FileImage(File(_image!.path)), fit: BoxFit.cover)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
              const EditItem(
                title: "Name",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "Age",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "Email",
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () => print('save'),
                text: "update",
              )
            ],
          ),
        ),
      ),
    );
  }
}
