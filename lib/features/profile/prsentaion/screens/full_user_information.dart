import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
import 'package:devti_agro/features/user/aplication/bloc/delete_add_update_user/delete_add_update_user_bloc.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FullUserInformation extends StatefulWidget {
  final User user;
  const FullUserInformation({super.key, required this.user});

  @override
  State<FullUserInformation> createState() => _FullUserInformationState();
}

class _FullUserInformationState extends State<FullUserInformation> {
  bool isRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 240,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.amber,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 40, left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.circleChevronLeft,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(widget.user.name)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.sizeOf(context).width / 3,
                        right: MediaQuery.sizeOf(context).width / 3,
                        bottom: 30,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/avatar.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 54, 202, 54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "nom",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        widget.user.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ContainerInfo(
                  label: "Email",
                  value: widget.user.email ?? "ss@example.ss",
                ),
                ContainerInfo(
                  label: "Telephone",
                  value: widget.user.telephone ?? "06221xxxxx",
                ),
                ContainerInfo(
                  label: "Adresse",
                  value: widget.user.adresse ?? "Adresse",
                ),
                ContainerInfo(
                  label: "pays",
                  value: widget.user.pays ?? "morocco",
                ),
                ContainerInfo(
                  label: "ville",
                  value: widget.user.ville ?? "fes",
                ),
                const SizedBox(height: 100), // Add space for buttons
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: S.of(context).delete,
                        desc: S.of(context).are_you_sure,
                        titleTextStyle: Theme.of(context).textTheme.titleMedium,
                        descTextStyle: Theme.of(context).textTheme.titleMedium,
                        btnOkText: S.of(context).delete,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          setState(() {
                            isRun = true;
                          });
                          final result = await _deleteUser(context);

                          if (result) {
                            setState(() {
                              isRun = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('user is delete'),
                              ),
                            );
                            context.read<UserBloc>().add(RefreshUserEvent());
                          } else {
                            setState(() {
                              isRun = false;
                            });
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to delete user.'),
                              ),
                            );
                          }
                        },
                      ).show();
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(color: const Color.fromARGB(171, 244, 67, 54), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isRun == false
                              ? Text(
                                  S.of(context).delete,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: const Color.fromARGB(255, 104, 10, 3)),
                                )
                              : LoadingAnimationWidget.flickr(
                                  leftDotColor: const Color(0xFF1A1A3F),
                                  rightDotColor: const Color(0xFFEA3799),
                                  size: 30,
                                )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUserScreen(
                                  user: widget.user,
                                )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration:
                          BoxDecoration(color: const Color.fromARGB(255, 67, 197, 230), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color.fromARGB(255, 2, 52, 94))),
                      child: Text(
                        S.of(context).edit,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color.fromARGB(255, 2, 52, 94)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _deleteUser(BuildContext context) async {
    try {
      final deleteBloc = BlocProvider.of<AddDeleteUpdateUserBloc>(context);

      // Add delete user event
      deleteBloc.add(DeleteUserEvent(userId: widget.user.id!));

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

      setState(() {
        isRun = false;
      });

      return false;
    } catch (e) {
      return false;
    }
  }
}

class ContainerInfo extends StatelessWidget {
  final String label;
  final String value;
  const ContainerInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 201, 207, 201),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
