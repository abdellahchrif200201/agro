import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/features/permission/aplication/bloc/add_role_bloc/bloc/permission_bloc.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/edit_item.dart';
import 'package:devti_agro/features/role/aplication/bloc/add_role_bloc/bloc/role_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String? selectedPermission;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: Icon(
                Ionicons.checkmark,
                color: Theme.of(context).iconTheme.color,
              ),
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
                "Add User Account",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "Name",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "Tel",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "Email",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "password",
              ),
              const SizedBox(height: 40),
              const EditItem(
                title: "confirmation",
              ),
              const SizedBox(height: 40),
              const Divider(
                height: 10,
                color: Colors.green,
              ),
              const SizedBox(height: 40),
              FormElement(
                hint: "Select zone",
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                label: "permission",
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  builder: (context, state) {
                    if (state is LoadingPermissionState) {
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
                    } else if (state is LoadedPermissionState) {
                      final List<String> options = state.permissions.map((zone) => zone.name).toList();

                      // Reset selectedPermission if it is not in the options
                      if (selectedPermission != null && !options.contains(selectedPermission)) {
                        setState(() {
                          selectedPermission = options.isNotEmpty ? options[0] : null;
                        });
                      }

                      return DropdownTwo(
                        hint: "Select zone",
                        dropDownItems: options,
                        onChanged: (value) {
                          setState(() {
                            selectedPermission = value;
                          });
                        },
                      );
                    } else if (state is ErrorPermissionState) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    }
                    return const Center(child: Text("loading ..."));
                  },
                ),
              ),
              const SizedBox(height: 40),
              FormElement(
                hint: "Select Role",
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                label: "Role",
                child: BlocBuilder<RoleBloc, RoleState>(
                  builder: (context, state) {
                    if (state is LoadingRoleState) {
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
                    } else if (state is LoadedRoleState) {
                      final List<String> options = state.roles.map((role) => role.name).toList();

                      // Reset selectedRole if it is not in the options
                      if (selectedRole != null && !options.contains(selectedRole)) {
                        setState(() {
                          selectedRole = options.isNotEmpty ? options[0] : null;
                        });
                      }

                      return DropdownTwo(
                        hint: "Select Role",
                        dropDownItems: options,
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value;
                          });
                        },
                      );
                    } else if (state is ErrorRoleState) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    }
                    return const Center(child: Text("loading ..."));
                  },
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () => print('save'),
                text: "add user",
              )
            ],
          ),
        ),
      ),
    );
  }
}
