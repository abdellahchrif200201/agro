import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:devti_agro/features/profile/prsentaion/services/user_service.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/features/user/aplication/model/user_model.dart';
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
  bool isRun = false;

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
    final userService = UserService(context: context);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(
          widget.user == null ? "Create user" : "Edit user",
          style: TextStyle(color: Colors.black),
        ),
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _telController,
                    decoration: InputDecoration(
                      labelText: "Tel",
                      hintText: 'Tel',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _confirmationController,
                    decoration: InputDecoration(
                      labelText: "Confirmation",
                      hintText: 'Confirmation',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
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
                          return _buildLoadingWidget();
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
                          return _buildErrorWidget(state.message);
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
                          return _buildLoadingWidget();
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
                          return _buildErrorWidget(state.message);
                        }
                        return const Center(child: Text("Loading..."));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 30,
            right: 30,
            child: CustomButton(
              isRun: isRun,
              onPressed: () async {
                setState(() {
                  isRun = true;
                });
                final name = _nameController.text;
                final telephone = _telController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                final confirmation = _confirmationController.text;

                if (password != confirmation) {
                  _showSnackbar('Passwords do not match.');
                  setState(() {
                    isRun = false;
                  });
                  return;
                }

                if (name.isEmpty || telephone.isEmpty || email.isEmpty || password.isEmpty) {
                  _showSnackbar('Please fill all fields.');
                  setState(() {
                    isRun = false;
                  });
                  return;
                }

                final userModel = UserModel(
                  name: name,
                  image: "data:image/png;base64,iVBORw0KGgoAAAIgeDp", // Default or placeholder image
                  entrepriseId: 1, // Make sure this is valid
                  email: email,
                  telephone: telephone,
                  adresse: "test yes", // Set as needed
                  pays: "test yes", // Set as needed
                  ville: "test yes", // Set as needed
                  password: password,
                );

                if (widget.user == null) {
                  final success = await userService.addUser(userModel);

                  if (success) {
                    setState(() {
                      isRun = false;
                    });
                    _showSnackbar("yes");
                  }
                } else {
                  final userModelUpdate = UserModel(
                    id: widget.user!.id,
                    name: name,
                    image: "data:image/png;base64,iVBORw0KGgoAAAIgeDp", // Default or placeholder image
                    entrepriseId: 1, // Make sure this is valid
                    email: email,
                    telephone: telephone,
                    adresse: "", // Set as needed
                    pays: "", // Set as needed
                    ville: "test", // Set as needed
                    password: password,
                  );

                  await userService.updateUser(userModelUpdate);
                  _showSnackbar("yes");
                }
              },
              text: widget.user == null ? "Add User" : "Update User",
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: LoadingAnimationWidget.waveDots(
        color: Colors.blue,
        size: 50,
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(child: Text('Error: $message'));
  }
}


// import 'package:devti_agro/features/profile/prsentaion/services/user_service.dart';
// import 'package:devti_agro/features/user/domain/entities/user.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:devti_agro/features/user/aplication/model/user_model.dart';
// import 'package:devti_agro/features/permission/aplication/bloc/add_role_bloc/bloc/permission_bloc.dart';
// import 'package:devti_agro/features/role/aplication/bloc/add_role_bloc/bloc/role_bloc.dart';
// import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
// import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
// import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';

// class AddUserScreen extends StatefulWidget {
//   final User? user;
//   const AddUserScreen({super.key, this.user});

//   @override
//   State<AddUserScreen> createState() => _AddUserScreenState();
// }

// class _AddUserScreenState extends State<AddUserScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _telController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmationController = TextEditingController();

//   String? selectedPermission;
//   String? selectedRole;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.user != null) {
//       _nameController.text = widget.user!.name;
//       _telController.text = widget.user!.telephone ?? "0000xxxxx";
//       _emailController.text = widget.user!.email ?? "ss@exmple.ss";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userService = UserService(context: context);

//     return Scaffold(
//       backgroundColor: Theme.of(context).canvasColor,
//       appBar: AppBar(
//         title: Text(
//           widget.user == null ? "Create user" : "Edit user",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Add User Account",
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: "name", hintText: ' name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _telController,
//                 decoration: InputDecoration(labelText: "Tel", hintText: ' Tel', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email", hintText: ' Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: "Password", hintText: ' Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _confirmationController,
//                 decoration: InputDecoration(labelText: "Confirmation", hintText: ' Confirmation', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
//               ),
//               const SizedBox(height: 40),
//               const Divider(
//                 height: 10,
//                 color: Colors.green,
//               ),
//               const SizedBox(height: 40),
//               FormElement(
//                 hint: "Select Permission",
//                 textStyle: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//                 label: "Permission",
//                 child: BlocBuilder<PermissionBloc, PermissionState>(
//                   builder: (context, state) {
//                     if (state is LoadingPermissionState) {
//                       return _buildLoadingWidget();
//                     } else if (state is LoadedPermissionState) {
//                       final List<String> options = state.permissions.map((permission) => permission.name).toList();

//                       return DropdownTwo(
//                         hint: "Select Permission",
//                         dropDownItems: options,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedPermission = value;
//                           });
//                         },
//                       );
//                     } else if (state is ErrorPermissionState) {
//                       return _buildErrorWidget(state.message);
//                     }
//                     return const Center(child: Text("Loading..."));
//                   },
//                 ),
//               ),
//               const SizedBox(height: 40),
//               FormElement(
//                 hint: "Select Role",
//                 textStyle: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//                 label: "Role",
//                 child: BlocBuilder<RoleBloc, RoleState>(
//                   builder: (context, state) {
//                     if (state is LoadingRoleState) {
//                       return _buildLoadingWidget();
//                     } else if (state is LoadedRoleState) {
//                       final List<String> options = state.roles.map((role) => role.name).toList();

//                       return DropdownTwo(
//                         hint: "Select Role",
//                         dropDownItems: options,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedRole = value;
//                           });
//                         },
//                       );
//                     } else if (state is ErrorRoleState) {
//                       return _buildErrorWidget(state.message);
//                     }
//                     return const Center(child: Text("Loading..."));
//                   },
//                 ),
//               ),
//               const SizedBox(height: 40),
//               CustomButton(
//                 onPressed: () async {
//                   final name = _nameController.text;
//                   final telephone = _telController.text;
//                   final email = _emailController.text;
//                   final password = _passwordController.text;
//                   final confirmation = _confirmationController.text;

//                   if (password != confirmation) {
//                     _showSnackbar('Passwords do not match.');
//                     return;
//                   }

//                   if (name.isEmpty || telephone.isEmpty || email.isEmpty || password.isEmpty) {
//                     _showSnackbar('Please fill all fields.');
//                     return;
//                   }

//                   final userModel = UserModel(
//                     name: name,
//                     image: "data:image/png;base64,iVBORw0KGgoAAAIgeDp", // Default or placeholder image
//                     entrepriseId: 1, // Make sure this is valid
//                     email: email,
//                     telephone: telephone,
//                     adresse: "", // Set as needed
//                     pays: "", // Set as needed
//                     ville: "", // Set as needed
//                     password: password,
//                   );

//                   if (widget.user == null) {
//                     final success = await userService.addUser(userModel);

//                     if (success) {
//                       Navigator.pop(context);
//                     }
//                   } else {
//                     final userModelUpdate = UserModel(
//                       id: widget.user!.id,
//                       name: name,
//                       image: "data:image/png;base64,iVBORw0KGgoAAAIgeDp", // Default or placeholder image
//                       entrepriseId: 1, // Make sure this is valid
//                       email: email,
//                       telephone: telephone,
//                       adresse: "", // Set as needed
//                       pays: "", // Set as needed
//                       ville: "test", // Set as needed
//                       password: password,
//                     );

//                     await userService.updateUser(userModelUpdate);
//                     Navigator.pop(context);
//                   }
//                 },
//                 text: widget.user == null ? "Add User" : "Update User",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   Widget _buildLoadingWidget() {
//     return Center(
//       child: LoadingAnimationWidget.waveDots(
//         color: Colors.blue,
//         size: 50,
//       ),
//     );
//   }

//   Widget _buildErrorWidget(String message) {
//     return Center(child: Text('Error: $message'));
//   }
// }

