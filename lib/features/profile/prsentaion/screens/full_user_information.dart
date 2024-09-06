// import 'package:devti_agro/features/profile/prsentaion/widgets/edit_item.dart';
// import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
// import 'package:devti_agro/features/user/domain/entities/user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';

// class FullUserInformation extends StatelessWidget {
//   final User user;
//   const FullUserInformation({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Ionicons.chevron_back_outline,
//             color: Theme.of(context).iconTheme.color,
//           ),
//         ),
//         leadingWidth: 80,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: IconButton(
//               onPressed: () {},
//               style: IconButton.styleFrom(
//                 backgroundColor: Colors.lightBlueAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 fixedSize: const Size(60, 50),
//                 elevation: 3,
//               ),
//               icon: const Icon(Ionicons.checkmark, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Account",
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(35),
//                       image: const DecorationImage(
//                         image: AssetImage("assets/images/avatar.png"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     onPressed: () {},
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.lightBlueAccent,
//                     ),
//                     child: const Text("Upload Image"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               EditItem(
//                 title: "Name",
//                 widget: Text(user.name),
//               ),
//               const SizedBox(height: 40),
//               const EditItem(
//                 title: "Telephone",
//                 widget: Text("0600002323"),
//               ),
//               const SizedBox(height: 40),
//               const EditItem(
//                 title: "Email",
//                 widget: Text("username@example.test"),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       BlocProvider.of<AddDeleteUpdateUserBloc>(context).add(
//                         DeleteUserEvent(userId: user.id),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.red, // Changed color to red for delete action
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Text(
//                         "Delete",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/edit_item.dart';
import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class FullUserInformation extends StatelessWidget {
  final User user;
  const FullUserInformation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              icon: const Icon(Ionicons.checkmark, color: Colors.white),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/avatar.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.lightBlueAccent,
                    ),
                    child: const Text("Upload Image"),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Name",
                widget: Text(user.name),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "adresse",
                widget: Text(user.adresse ?? 'not found'),
              ),
              SizedBox(height: 40),
              EditItem(
                title: "Email",
                widget: Text(user.email ?? "email not found"),
              ),
              EditItem(
                title: "telephone",
                widget: Text(user.telephone ?? "email not found"),
              ),
              EditItem(
                title: "Pays",
                widget: Text(user.pays ?? "email not found"),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Show loading indicator
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (context) => const Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // );

                      // Perform delete operation
                      final result = await _deleteUser(context);

                      // Dismiss the loading indicator

                      // Navigate or show a message based on the result
                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('user is delete'),
                          ),
                        );
                        context.read<UserBloc>().add(RefreshUserEvent());
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to delete user.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.red, // Changed color to red for delete action
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUserScreen(
                                  user: user,
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Changed color to red for delete action
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
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

  Future<bool> _deleteUser(BuildContext context) async {
    try {
      final deleteBloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

      // Add delete user event
      deleteBloc.add(DeleteUserEvent(userId: user.id!));

      // Listen for state changes
      final state = await deleteBloc.stream.firstWhere(
        (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
      );

      if (state is MessageAddDeleteUpdateUserState) {
        // Check if message contains success confirmation
        if (state.message == DELETE_SUCCESS_MESSAGE) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
