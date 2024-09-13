// // user_service.dart
// import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
// import 'package:devti_agro/features/user/aplication/model/user_model.dart';
// import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';

// class UserService {
//   Future<bool> addUser(BuildContext context, UserModel userModel) async {
//     try {
//       final deleteBloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

//       // Add user event
//       deleteBloc.add(AddUserEvent(user: userModel));

//       final state = await deleteBloc.stream.firstWhere(
//         (state) => state is ErrorAddDeleteUpdateUserState || state is MessageAddDeleteUpdateUserState,
//         orElse: () {
//           print("No relevant state received.");
//           return const ErrorAddDeleteUpdateUserState(message: 'Unknown error.');
//         },
//       ).timeout(const Duration(seconds: 10), onTimeout: () {
//         print("Timeout occurred.");
//         return const ErrorAddDeleteUpdateUserState(message: 'Timeout error.');
//       });

//       if (state is MessageAddDeleteUpdateUserState) {
//         print("Message state received: ${state.message}");
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('User added successfully.'),
//           ),
//         );

//         context.read<UserBloc>().add(RefreshUserEvent());

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AllUsersScreen()));

//         if (state.message.trim() == 'User created successfully') {
//           return true;
//         }
//       } else if (state is ErrorAddDeleteUpdateUserState) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to add user.'),
//           ),
//         );

//         print("Error state received: ${state.message}");
//       }

//       return false;
//     } catch (e) {
//       print("Exception occurred: $e");
//       return false;
//     }
//   }
// }
