import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:devti_agro/core/strings/failures.dart';
import 'package:devti_agro/core/widgets/custom_menu/checklist_menu_button.dart';
import 'package:devti_agro/features/Checklist/application/bloc/add_delete_update_tache/add_delete_update_tache_bloc.dart';
import 'package:devti_agro/features/Checklist/application/bloc/get_all_check_list/check_list_bloc.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../screens/create_Checklist_screen.dart';

class ChecklistCard extends StatefulWidget {
  final CheckList checkList;

  const ChecklistCard({super.key, required this.checkList});

  @override
  State<ChecklistCard> createState() => _ChecklistCardState();
}

class _ChecklistCardState extends State<ChecklistCard> {
  bool _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    // Convert the date string to a DateTime object
    final DateTime date = DateTime.tryParse(widget.checkList.date ?? '') ?? DateTime.now();
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: themeBloc ? Color(0xff7A1CAC).withOpacity(0.3) : const Color(0xffD2D2D2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.checkList.tasksName ?? "test",
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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
                                checkList: widget.checkList,
                              ),
                            ),
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
                label: widget.checkList.category ?? 'No Category',
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
                  widget.checkList.description ?? 'No Description',
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
    if (!_isDeleting) {
      _isDeleting = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: LoadingAnimationWidget.newtonCradle(
            color: const Color.fromARGB(255, 13, 200, 63),
            size: 30,
          ),
        ),
      );
    }

    try {
      final deleteBloc = BlocProvider.of<AddDeleteUpdateTacheBloc>(context);

      // Add delete user event
      deleteBloc.add(DeleteTacheEvent(tacheId: widget.checkList.id!));

      // Listen for state changes
      final state = await deleteBloc.stream.firstWhere(
        (state) => state is ErrorAddDeleteUpdateTacheState || state is MessageAddDeleteUpdateTacheState,
      );

      // Dismiss the loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context, rootNavigator: true).pop(); // Ensure dialog is dismissed
      }

      if (state is MessageAddDeleteUpdateTacheState) {
        if (state.message == DELETE_SUCCESS_MESSAGE) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Checklist deleted successfully')),
          );

          BlocProvider.of<CheckListBloc>(context).add(const FilterCheckListEvent(filterType: 'date', isAscending: true));

          // Optionally, you can update the state of the widget to reflect the deletion
          // This is an example of using setState to rebuild the widget if needed
          // You might need to refactor depending on how your state management is set up
          setState(() {
            // If using a list of checklists, you might need to remove the checklist from the list
            // e.g., _checklists.remove(widget.checkList);
          });
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
    } finally {
      _isDeleting = false; // Reset the flag
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
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: themeBloc ? backgroundDark : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8.0),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
