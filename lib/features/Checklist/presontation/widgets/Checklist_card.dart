import 'package:devti_agro/core/widgets/custom_menu/checklist_menu_button.dart';
import 'package:devti_agro/features/Checklist/domain/entities/check_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;


class ChecklistCard extends StatelessWidget {
  final CheckList checkList;

  const ChecklistCard({super.key, required this.checkList});

  @override
  Widget build(BuildContext context) {
    // Convert the date string to a DateTime object
    final DateTime date = DateTime.parse(checkList.date!);

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
              Text(checkList.tasksName!, style: Theme.of(context).textTheme.labelMedium),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 15,
                  ),
                  ChecklistMenuButton(
                    onMenuItemSelected: (String value) {
                      // Handle the selected menu option
                      switch (value) {
                        case 'Edit':
                          // Handle edit action
                          break;
                        case 'Delete':
                          // Handle delete action
                          break;
                        case 'Share':
                          // Handle share action
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
                label: checkList.category!,
                icon: const FaIcon(
                  FontAwesomeIcons.layerGroup,
                  size: 15,
                ),
              ),
              const SizedBox(width: 15),
              CheckListLocalContainer(
                label: checkList.zone!,
                icon: const FaIcon(
                  FontAwesomeIcons.earthAfrica,
                  size: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  checkList.description!,
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
