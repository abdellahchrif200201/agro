// import 'package:devti_agro/core/widgets/Custom_dropdown/dorp_down_two.dart';
// import 'package:devti_agro/core/widgets/Custom_form_element/FomElement.dart';
// import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
// import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
// import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class AddScreen extends StatefulWidget {
//   final CheckList? checkList;

//   AddScreen({this.checkList});

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> {
//   String? selectedItem;
//   String? selectedCategory;

//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController explainController = TextEditingController();

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
//     setState(() {
//       if (widget.checkList != null) {
//         _dateController.text = widget.checkList!.date.toString();
//         _titleController.text = widget.checkList!.tasksName.toString();
//         _descriptionController.text = widget.checkList!.description.toString();
//         selectedUser = widget.checkList!.userName;
//         selectIdUser = widget.checkList!.userId;
//         selectedStatus = widget.checkList!.status;
//       }
//     });
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
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: Stack(
//           alignment: AlignmentDirectional.center,
//           children: [
//             _buildBackgroundContainer(context),
//             Positioned(
//               top: 120,
//               child: _buildMainContainer(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Container _buildMainContainer() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//       ),
//       height: 550,
//       width: 340,
//       child: Column(
//         children: [
//           SizedBox(height: 50),
//           _buildNameDropdown(),
//           SizedBox(height: 30),
//           _buildExplainField(),
//           SizedBox(height: 30),
//           _buildAmountField(),
//           SizedBox(height: 30),
//           _buildCategoryDropdown(),

//           // SizedBox(height: 30),
//           // _buildDateTimePicker(),
//           Spacer(),
//           _buildSaveButton(),
//           SizedBox(height: 25),
//         ],
//       ),
//     );
//   }

//   GestureDetector _buildSaveButton() {
//     return GestureDetector(
//       onTap: () {
//         // Add your save logic here
//       },
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Color(0xff368983),
//         ),
//         width: 120,
//         height: 50,
//         child: Text(
//           'Save',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//             fontSize: 17,
//           ),
//         ),
//       ),
//     );
//   }

//   Padding _buildCategoryDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         width: 300,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             width: 2,
//             color: Color(0xffC5C5C5),
//           ),
//         ),
//         child: DropdownTwo(
//           dropDownItems: const ["Afaire", "enCour", "Traite", "Bloque"],
//           hint: selectedStatus ?? "Select status",
//           onChanged: (value) {
//             setState(() {
//               selectedStatus = value;
//             });
//           },
//         ),
//       ),
//     );
//   }

//   Padding _buildAmountField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         controller: amountController,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           labelText: 'Amount',
//           labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(width: 2, color: Color(0xff368983)),
//           ),
//         ),
//       ),
//     );
//   }

//   Padding _buildExplainField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: TextField(
//         controller: explainController,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           labelText: 'Explain',
//           labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(width: 2, color: Color(0xff368983)),
//           ),
//         ),
//       ),
//     );
//   }

//   Padding _buildNameDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         width: 300,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             width: 2,
//             color: Color(0xffC5C5C5),
//           ),
//         ),
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is LoadingUserState) {
//               return _buildLoadingIndicator();
//             } else if (state is LoadedUserState) {
//               final List<String> options = state.users.map((user) => user.name).toList();
//               final List<int?> ids = state.users.map((user) => user.id).toList();

//               if (selectedUser != null && !options.contains(selectedUser)) {
//                 setState(() {
//                   selectedUser = options.isNotEmpty ? options[0] : null;
//                   selectIdUser = ids.isNotEmpty ? ids[0] : null;
//                 });
//               }

//               return DropdownTwo(
//                 hint: selectedUser ?? "select user",
//                 dropDownItems: options,
//                 onChanged: (value) {
//                   final selectedIndex = options.indexOf(value!);
//                   setState(() {
//                     selectedUser = value;
//                     selectIdUser = ids[selectedIndex];
//                   });
//                 },
//               );
//             } else if (state is ErrorUserState) {
//               return RefreshData(
//                 onPressed: () => context.read<UserBloc>().add(GetAllUserEvent()),
//               );
//             }
//             return const Center(child: Text("Loading..."));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const Text("Loading..."),
//           LoadingAnimationWidget.newtonCradle(
//             color: const Color.fromARGB(255, 13, 200, 63),
//             size: 30,
//           ),
//         ],
//       ),
//     );
//   }

//   Column _buildBackgroundContainer(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 240,
//           decoration: BoxDecoration(
//             color: Color(0xff368983),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Icon(Icons.arrow_back, color: Colors.white),
//                     ),
//                     Text(
//                       'Adding',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Icon(
//                       Icons.attach_file_outlined,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Placeholder for the date/time picker
// }
