import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/core/widgets/custom_menu/checklist_menu_button.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../screens/create_Checklist_screen.dart';

class ChecklistCard extends StatelessWidget {
  final CheckList checkList;

  const ChecklistCard({super.key, required this.checkList});

  @override
  Widget build(BuildContext context) {
    // Convert the date string to a DateTime object
    final DateTime date = DateTime.tryParse(checkList.date ?? '') ?? DateTime.now();

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xffD2D2D2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  checkList.tasksName ?? "test",
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis, // This ensures the text is truncated if it exceeds maxLines
                ),
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 15,
                  ),
                  ChecklistMenuButton(
                    onMenuItemSelected: (String value) {
                      switch (value) {
                        case 'Edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateChecklist(
                                      checkList: checkList,
                                    )), // Replace NextPage with your target page
                          );
                          break;
                        case 'Delete':
                          _deleteUser(context);
                          break;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CheckListLocalContainer(
                label: checkList.category ?? 'No Category',
                icon: const FaIcon(
                  FontAwesomeIcons.layerGroup,
                  size: 15,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  checkList.description ?? 'No Description',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xff717171)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                timeago.format(date),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteUser(BuildContext context) async {
    final deleteBloc = BlocProvider.of<AddDeleteUpdateTacheBloc>(context);

    // Add delete user event
    deleteBloc.add(DeleteTacheEvent(tacheId: checkList.id!));

    // Listen for state changes
    final state = await deleteBloc.stream.firstWhere(
      (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
    );

    if (state is MessageAddDeleteUpdateTacheState) {
      // Check if message contains success confirmation
      if (state.message == DELETE_SUCCESS_MESSAGE) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Checklist deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete checklist')),
        );
      }
    } else if (state is ErrorAddDeleteUpdateTacheState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }
}

class CheckListLocalContainer extends StatelessWidget {
  final String label;
  final FaIcon icon;

  const CheckListLocalContainer({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Increased padding for better spacing
      decoration: BoxDecoration(
        color: const Color(0xffEEEDEB), // Light grey background
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Makes the row only as wide as needed
        children: [
          icon, // Add the icon
          const SizedBox(width: 8.0), // Space between icon and text
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
