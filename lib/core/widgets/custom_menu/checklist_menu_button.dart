import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChecklistMenuButton extends StatelessWidget {
  final Function(String) onMenuItemSelected;

  const ChecklistMenuButton({super.key, required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color.fromARGB(255, 173, 170, 170),
      icon: const FaIcon(
        FontAwesomeIcons.ellipsis,
        color: Colors.black,
      ),
      onSelected: onMenuItemSelected,
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 10),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'Delete',
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 10),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}
