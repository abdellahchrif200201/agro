// import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
// import 'package:devti_agro/features/Checklist/presontation/services/tache_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

// // import 'tache_service.dart'; // Import the service
// import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
// import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
// import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
// import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
// import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
// import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
// import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';

// class CreateChecklist extends StatefulWidget {
//   final CheckList? checkList;

//   CreateChecklist({this.checkList});
//   @override
//   _CreateChecklistState createState() => _CreateChecklistState();
// }

// class _CreateChecklistState extends State<CreateChecklist> {
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   String? selectedUser;
//   int? selectIdUser;
//   String? selectedStatus;
//   bool isRun = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.checkList != null) {
//       _dateController.text = widget.checkList!.date.toString();
//       _titleController.text = widget.checkList!.tasksName.toString();
//       _descriptionController.text = widget.checkList!.description.toString();
//       selectedUser = widget.checkList!.userName;
//       selectIdUser = widget.checkList!.userId;
//       selectedStatus = widget.checkList!.status;
//     }
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         _dateController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tacheService = TacheService(bloc: BlocProvider.of<AddDeleteUpdateTacheBloc>(context));

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Create Checklist",
//           style: TextStyle(color: Colors.black),
//         ),
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
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Title",
//                 label: "Title",
//                 child: TextFormField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Description",
//                 label: "Description",
//                 maxLines: 5,
//                 child: TextFormField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Select date",
//                 label: "Date",
//                 child: TextFormField(
//                   controller: _dateController,
//                   decoration: const InputDecoration(
//                     hintText: "Select date",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: InputBorder.none,
//                   ),
//                   onTap: () {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                     _selectDate(context);
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               FormElement(
//                 hint: "Select user",
//                 label: "User",
//                 child: BlocBuilder<UserBloc, UserState>(
//                   builder: (context, state) {
//                     if (state is LoadingUserState) {
//                       return _buildLoadingIndicator();
//                     } else if (state is LoadedUserState) {
//                       final List<String> options = state.users.map((user) => user.name).toList();
//                       final List<int?> ids = state.users.map((user) => user.id).toList();

//                       if (selectedUser != null && !options.contains(selectedUser)) {
//                         setState(() {
//                           selectedUser = options.isNotEmpty ? options[0] : null;
//                           selectIdUser = ids.isNotEmpty ? ids[0] : null;
//                         });
//                       }

//                       return DropdownTwo(
//                         hint: selectedUser ?? "select user",
//                         dropDownItems: options,
//                         onChanged: (value) {
//                           final selectedIndex = options.indexOf(value!);
//                           setState(() {
//                             selectedUser = value;
//                             selectIdUser = ids[selectedIndex];
//                           });
//                         },
//                       );
//                     } else if (state is ErrorUserState) {
//                       return RefreshData(
//                         onPressed: () => context.read<UserBloc>().add(GetAllUserEvent()),
//                       );
//                     }
//                     return const Center(child: Text("Loading..."));
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//               FormElement(
//                 hint: "Select status",
//                 label: "Status",
//                 child: DropdownTwo(
//                   dropDownItems: const ["Afaire", "enCour", "Traite", "Bloque"],
//                   hint: selectedStatus ?? "Select status",
//                   onChanged: (value) {
//                     setState(() {
//                       selectedStatus = value;
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 40),
//               CustomButton(
//                 isRun: isRun,
//                 onPressed: () async {
//                   setState(() {
//                     isRun = true;
//                   });

//                   final tache = CheckListModel(
//                     tasksName: _titleController.text,
//                     entrepriseId: 1, // Replace with the actual enterprise ID
//                     date: _dateController.text,
//                     type: "ROOM", // Replace with the actual type
//                     status: selectedStatus ?? "Afaire", // Default to "Afaire" if null
//                     description: _descriptionController.text,
//                     userId: selectIdUser, // Replace with the actual user ID
//                   );

//                   final success = widget.checkList != null ? await tacheService.updateTache(tache.copyWith(id: widget.checkList!.id)) : await tacheService.addTache(tache);

//                   if (success) {
//                     showTopSnackBar(
//                       Overlay.of(context),
//                       CustomSnackBar.success(
//                         message: widget.checkList != null ? "Tache updated successfully" : "Tache added successfully",
//                       ),
//                     );
//                     // Navigator.pop(context);
//                   } else {
//                     showTopSnackBar(
//                       Overlay.of(context),
//                       const CustomSnackBar.error(
//                         message: "Failed to add/update tache",
//                       ),
//                     );
//                   }

//                   setState(() {
//                     isRun = false;
//                   });
//                 },
//                 text: widget.checkList != null ? "Update" : "Add",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Center(
//       child: LoadingAnimationWidget.inkDrop(
//         color: Colors.blue,
//         size: 30,
//       ),
//     );
//   }
// }

import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/text_field_widget.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateChecklist extends StatefulWidget {
  final CheckList? checkList;

  CreateChecklist({this.checkList});
  @override
  _CreateChecklistState createState() => _CreateChecklistState();
}

class _CreateChecklistState extends State<CreateChecklist> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedUser;
  int? selectIdUser;
  String? selectedStatus;
  bool isRun = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.checkList != null) {
        _dateController.text = widget.checkList!.date.toString();
        _titleController.text = widget.checkList!.tasksName.toString();
        _descriptionController.text = widget.checkList!.description.toString();
        selectedUser = widget.checkList!.userName;
        selectIdUser = widget.checkList!.userId;
        selectedStatus = widget.checkList!.status;
      }
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          title: Text(
            S.of(context).create_new,
            style: TextStyle(color: themeBloc ? Colors.white : Colors.black),
          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: _titleController,
                      hintText: S.of(context).titre,
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(controller: _descriptionController, hintText: S.of(context).description, maxLines: 5),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: S.of(context).select_date,
                        hintStyle: const TextStyle(color: Colors.grey),
                        // border: InputBorder.none,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _selectDate(context);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is LoadingUserState) {
                          return _buildLoadingIndicator();
                        } else if (state is LoadedUserState) {
                          final List<String> options = state.users.map((user) => user.name).toList();
                          final List<int?> ids = state.users.map((user) => user.id).toList();

                          if (selectedUser != null && !options.contains(selectedUser)) {
                            setState(() {
                              selectedUser = options.isNotEmpty ? options[0] : null;
                              selectIdUser = ids.isNotEmpty ? ids[0] : null;
                            });
                          }

                          return DropdownTwo(
                            border: true,
                            hint: selectedUser ?? S.of(context).select_user,
                            dropDownItems: options,
                            onChanged: (value) {
                              final selectedIndex = options.indexOf(value!);
                              setState(() {
                                selectedUser = value;
                                selectIdUser = ids[selectedIndex];
                              });
                            },
                          );
                        } else if (state is ErrorUserState) {
                          return RefreshData(
                            onPressed: () => context.read<UserBloc>().add(GetAllUserEvent()),
                          );
                        }
                        return Center(child: Text("${S.of(context).loading}..."));
                      },
                    ),
                    // Text(selectedUser!),
                    // Text(selectIdUser.toString()),
                    const SizedBox(height: 16),
                    DropdownTwo(
                      border: true,
                      dropDownItems: const ["Afaire", "enCour", "Traite", "Bloque"],
                      hint: selectedStatus ?? S.of(context).select_status,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 60),
                    // Positioned(
                    //   bottom: 0,
                    //   child: ,
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 10,
                left: 10,
                child: CustomButton(
                  isRun: isRun,
                  onPressed: () {
                    setState(() {
                      isRun = true;
                    });
                    widget.checkList != null ? _updateTache(context) : _addTache(context);
                  },
                  text: widget.checkList != null ? S.of(context).edit : S.of(context).save,
                ))
          ],
        ));
  }

  Widget _buildLoadingIndicator() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
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
  }

  Future<void> _addTache(BuildContext context) async {
    final bloc = BlocProvider.of<AddDeleteUpdateTacheBloc>(context);

    final tache = CheckListModel(
      tasksName: _titleController.text,
      entrepriseId: 1, // Replace with the actual enterprise ID
      date: _dateController.text,
      type: "ROOM", // Replace with the actual type
      status: selectedStatus ?? "Afaire", // Default to "Afaire" if null
      description: _descriptionController.text,
      userId: selectIdUser, // Replace with the actual user ID
    );

    bloc.add(AddTacheEvent(tache: tache));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
    );

    if (state is MessageAddDeleteUpdateTacheState) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: S.of(context).tache_added,
        ),
      );
      setState(() {
        isRun = false;
      });
    } else {
      // Handle error
      // print("non");
      setState(() {
        isRun = false;
      });
    }
  }

  Future<void> _updateTache(BuildContext context) async {
    final bloc = BlocProvider.of<AddDeleteUpdateTacheBloc>(context);

    final tache = CheckListModel(
      id: widget.checkList!.id,
      tasksName: _titleController.text,
      //entrepriseId: 1, // Replace with the actual enterprise ID
      date: _dateController.text,
      type: "ROOM", // Replace with the actual type
      status: selectedStatus ?? widget.checkList!.status, // Default to "Afaire" if null
      description: _descriptionController.text,
      userId: selectIdUser, // Replace with the actual user ID
    );

    bloc.add(UpdateTacheEvent(tache: tache));

    final state = await bloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
    );

    if (state is MessageAddDeleteUpdateTacheState && state.message == UPDATE_SUCCESS_MESSAGE) {
      setState(() {
        isRun = false;
      });

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: S.of(context).tache_updated,
        ),
      );
    } else {
      // print('non');
      setState(() {
        isRun = false;
      });

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: S.of(context).try_again,
        ),
      );
    }
  }
}
