import 'dart:io';

import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/edit_account_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/forward_button.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/setting_item.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart'; // Add this import

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
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

  Future<void> _loadUserData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("auth_token");
    prefs.remove("name");

    // Navigate to login or another screen after logout
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage, // Trigger image picker on tap
                      child: Container(
                        width: 70,
                        height: 70,
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
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Uranus Code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Youtube Channel",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        if (5 == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditAccountScreen()),
                          );
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'login',
                            desc: 'you are not login ?',
                            titleTextStyle: Theme.of(context).textTheme.titleMedium,
                            descTextStyle: Theme.of(context).textTheme.titleMedium,
                            btnOkText: 'conextion',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            ),
                          ).show();
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "add user",
                icon: Ionicons.add_circle,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  if (5 == 6) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddUserScreen()),
                    );
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'login',
                      desc: 'you are not login ?',
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      descTextStyle: Theme.of(context).textTheme.titleMedium,
                      btnOkText: 'conextion',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      ),
                    ).show();
                  }
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "all user",
                icon: Ionicons.people,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  if (5 == 6) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllUsersScreen()),
                    );
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'login',
                      desc: 'you are not login ?',
                      titleTextStyle: Theme.of(context).textTheme.titleMedium,
                      descTextStyle: Theme.of(context).textTheme.titleMedium,
                      btnOkText: 'conextion',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      ),
                    ).show();
                  }
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Logout",
                icon: Ionicons.log_out,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Logout',
                    desc: 'are you sure ?',
                    titleTextStyle: Theme.of(context).textTheme.titleMedium,
                    descTextStyle: Theme.of(context).textTheme.titleMedium,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () => _loadUserData(context),
                  ).show();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
