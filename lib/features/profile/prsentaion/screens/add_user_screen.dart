import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/edit_item.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
import 'package:devti_agro/features/permission/aplication/bloc/add_role_bloc/bloc/permission_bloc.dart';
import 'package:devti_agro/features/role/aplication/bloc/add_role_bloc/bloc/role_bloc.dart';
import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';

class AddUserScreen extends StatefulWidget {
  final User? user;
  const AddUserScreen({super.key, this.user});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();

  String? selectedPermission;
  String? selectedRole;
  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _telController.text = widget.user!.telephone ?? "0000xxxxx";
      _emailController.text = widget.user!.email ?? "ss@exmple.ss";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text("Create user"),
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
              EditItem(controller: _nameController, title: "Name"),
              const SizedBox(height: 40),
              EditItem(controller: _telController, title: "Tel"),
              const SizedBox(height: 40),
              EditItem(controller: _emailController, title: "Email"),
              const SizedBox(height: 40),
              EditItem(controller: _passwordController, title: "Password"),
              const SizedBox(height: 40),
              EditItem(controller: _confirmationController, title: "Confirmation"),
              const SizedBox(height: 40),
              const Divider(
                height: 10,
                color: Colors.green,
              ),
              const SizedBox(height: 40),
              FormElement(
                hint: "Select Permission",
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                label: "Permission",
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  builder: (context, state) {
                    if (state is LoadingPermissionState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Loading..."),
                            LoadingAnimationWidget.newtonCradle(
                              color: const Color.fromARGB(255, 13, 200, 63),
                              size: 30,
                            ),
                          ],
                        ),
                      );
                    } else if (state is LoadedPermissionState) {
                      final List<String> options = state.permissions.map((permission) => permission.name).toList();

                      return DropdownTwo(
                        hint: "Select Permission",
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
                    return const Center(child: Text("Loading..."));
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
                            const Text("Loading..."),
                            LoadingAnimationWidget.newtonCradle(
                              color: const Color.fromARGB(255, 13, 200, 63),
                              size: 30,
                            ),
                          ],
                        ),
                      );
                    } else if (state is LoadedRoleState) {
                      final List<String> options = state.roles.map((role) => role.name).toList();

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
                    return const Center(child: Text("Loading..."));
                  },
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () async {
                  // Gather input values and create user model
                  final name = _nameController.text;
                  final telephone = _telController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final confirmation = _confirmationController.text;

                  if (password != confirmation) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Passwords do not match.'),
                      ),
                    );
                    return;
                  }

                  if (name.isEmpty || telephone.isEmpty || email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields.'),
                      ),
                    );
                    return;
                  }

                  final userModel = UserModel(
                    name: name,
                    image: "data:image/png;base64,", // Default or placeholder image
                    entrepriseId: 1, // Make sure this is valid
                    email: email,
                    telephone: telephone,
                    adresse: "", // Set as needed
                    pays: "", // Set as needed
                    ville: "", // Set as needed
                    password: password,
                  );

                  // Call _addUser with userModel
                  if (widget.user == null) {
                    final result = await _addUser(context, userModel);

                    if (result) {
                      print("yes");
                    } else {
                      print("non");
                    }
                  } else {
                    _updateUser(context);
                  }
                },
                text: "Add User",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _addUser(BuildContext context, UserModel userModel) async {
    try {
      final deleteBloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

      // Add user event
      deleteBloc.add(AddUserEvent(user: userModel));

      final state = await deleteBloc.stream.firstWhere(
        (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
        orElse: () {
          print("No relevant state received.");
          return ErrorAddDeleteUpdateUserState(message: 'Unknown error.');
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        print("Timeout occurred.");
        return ErrorAddDeleteUpdateUserState(message: 'Timeout error.');
      });

      if (state is MessageAddDeleteUpdateUserState) {
        print("Message state received: ${state.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added successfully.'),
          ),
        );

        context.read<UserBloc>().add(RefreshUserEvent());

        Navigator.push(context, MaterialPageRoute(builder: (context) => AllUsersScreen()));

        if (state.message.trim() == 'User created successfully') {
          return true;
        }
      } else if (state is ErrorAddDeleteUpdateUserState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add user.'),
          ),
        );

        print("Error state received: ${state.message}");
      }

      return false;
    } catch (e) {
      print("Exception occurred: $e");
      return false;
    }
  }

  Future<void> _updateUser(BuildContext context) async {
    final bloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

    final name = _nameController.text;
    final telephone = _telController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final userModel = UserModel(
      id: widget.user!.id,
      name: name,
      image: "data:image/png;base64,", // Default or placeholder image
      entrepriseId: 1, // Make sure this is valid
      email: email,
      telephone: telephone,
      adresse: "", // Set as needed
      pays: "", // Set as needed
      ville: "", // Set as needed
      password: password,
    );

    bloc.add(UpdateUserEvent(user: userModel));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
    );

    if (state is MessageAddDeleteUpdateUserState && state.message == UPDATE_SUCCESS_MESSAGE) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ChecklistScreen()),
      // );
      print("yes");
    } else {
      // Handle error
      print('non');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ChecklistScreen()),
      // );
    }
  }
}
