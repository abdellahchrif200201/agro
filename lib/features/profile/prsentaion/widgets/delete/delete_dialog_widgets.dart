// import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DeleteDialogWidget extends StatelessWidget {
//   final int userId;

//   const DeleteDialogWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Are you sure?"),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text("No"),
//         ),
//         BlocBuilder<AddDeleteUpdateUserBloc, AddDeleteUpdateUserState>(
//           builder: (context, state) {
//             if (state is LoadingAddDeleteUpdateUserState) {
//               return CircularProgressIndicator();
//             }
//             return TextButton(
//               onPressed: () {
//                 BlocProvider.of<AddDeleteUpdateUserBloc>(context).add(
//                   DeleteUserEvent(userId: userId),
//                 );
//               },
//               child: const Text("Yes"),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
