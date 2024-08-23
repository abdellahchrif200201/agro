import 'package:flutter/material.dart';

import 'FilterChipWidget.dart';


class FilterBottomSheet extends StatelessWidget {
  final VoidCallback onClose;
  final String title;
  final List<String> filterOptions;
  final Map<String, VoidCallback> filterActions;

  const FilterBottomSheet({
    Key? key,
    required this.onClose,
    required this.title,
    required this.filterOptions,
    required this.filterActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: filterOptions.map((option) {
              return FilterChipWidget(
                label: option,
                onTap: filterActions[option] ?? () {},
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

void showFilterBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> filterOptions,
  required Map<String, VoidCallback> filterActions,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return FilterBottomSheet(
        onClose: () {
          Navigator.pop(context);
        },
        title: title,
        filterOptions: filterOptions,
        filterActions: filterActions,
      );
    },
  );
}
