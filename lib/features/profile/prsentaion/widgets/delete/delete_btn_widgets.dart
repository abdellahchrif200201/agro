// import 'package:devti_agro/core/utils/snackbar_message.dart';
// import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
// import 'package:devti_agro/features/profile/prsentaion/widgets/delete/delete_dialog_widgets.dart';
// import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/widgets/loading_widget.dart';

// class DeleteUserBtnWidget extends StatelessWidget {
//   final int userId;

//   const DeleteUserBtnWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Colors.redAccent),
//       ),
//       onPressed: () => deleteDialog(context, userId),
//       icon: const Icon(Icons.delete_outline),
//       label: const Text("Delete"),
//     );
//   }

//   void deleteDialog(BuildContext context, int userId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return BlocConsumer<AddDeleteUpdateUserBloc, AddDeleteUpdateUserState>(
//           listener: (dialogContext, state) {
//             if (state is MessageAddDeleteUpdateUserState) {
//               SnackBarMessage().showSuccessSnackBar(
//                 message: state.message,
//                 context: dialogContext,
//               );
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (_) => AllUsersScreen()),
//                 (route) => false,
//               );
//             } else if (state is ErrorAddDeleteUpdateUserState) {
//               Navigator.of(dialogContext).pop();
//               SnackBarMessage().showErrorSnackBar(
//                 message: state.message,
//                 context: dialogContext,
//               );
//             }
//           },
//           builder: (dialogContext, state) {
//             if (state is LoadingAddDeleteUpdateUserState) {
//               return const AlertDialog(title: LoadingWidget());
//             }
//             return DeleteDialogWidget(userId: userId);
//           },
//         );
//       },
//     );
//   }
// }
