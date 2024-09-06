// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter/material.dart';

// class UserService {
//   final BuildContext context;

//   UserService(this.context);

//   Future<void> _updateTache(BuildContext context) async {
//     final bloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

//     final tache = CheckListModel(
//       id: widget.checkList!.id,
//       tasksName: _titleController.text,
//       //entrepriseId: 1, // Replace with the actual enterprise ID
//       date: _dateController.text,
//       type: "ROOM", // Replace with the actual type
//       status: selectedStatus ?? widget.checkList!.status, // Default to "Afaire" if null
//       description: _descriptionController.text,
//       userId: selectIdUser, // Replace with the actual user ID
//     );

//     bloc.add(UpdateTacheEvent(tache: tache));

//     final state = await bloc.stream.firstWhere(
//       (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
//     );

//     if (state is MessageAddDeleteUpdateTacheState && state.message == UPDATE_SUCCESS_MESSAGE) {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => ChecklistScreen()),
//       // );
//       print("object");
//     } else {
//       // Handle error
//       print('non');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ChecklistScreen()),
//       );
//     }
//   }
// }
