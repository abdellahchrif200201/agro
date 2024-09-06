import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/application/models/check_list_model.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/check_list_screen.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Checklist",
          style: TextStyle(color: Colors.black),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              FormElement(
                hint: "Title",
                label: "Title",
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FormElement(
                hint: "Description",
                label: "Description",
                maxLines: 5,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              FormElement(
                hint: "Select date",
                label: "Date",
                child: TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    hintText: "Select date",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              FormElement(
                hint: "Select user",
                label: "User",
                child: BlocBuilder<UserBloc, UserState>(
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
                        hint: selectedUser ?? "select user",
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
                    return const Center(child: Text("Loading..."));
                  },
                ),
              ),
              // Text(selectedUser!),
              // Text(selectIdUser.toString()),
              const SizedBox(height: 16),
              FormElement(
                hint: "Select status",
                label: "Status",
                child: DropdownTwo(
                  dropDownItems: const ["Afaire", "enCour", "Traite", "Bloque"],
                  hint: selectedStatus ?? "Select status",
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () {
                  widget.checkList != null ? _updateTache(context) : _addTache(context);
                  ;
                },
                text: widget.checkList != null ? "update" : "Save",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
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

    if (state is MessageAddDeleteUpdateTacheState && state.message == ADD_SUCCESS_MESSAGE) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChecklistScreen()),
      );
      print("object");
    } else {
      // Handle error
      print('non');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChecklistScreen()),
      );
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
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ChecklistScreen()),
      // );
      print("object");
    } else {
      // Handle error
      print('non');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChecklistScreen()),
      );
    }
  }
}
