import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TasksCard extends StatelessWidget {
  final Tasks task;
  const TasksCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding inside the container
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin around the container
      decoration: BoxDecoration(
        color: themeBloc ? Color(0xff151515) : Colors.white, // Background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.taskName,
            style: Theme.of(context).textTheme.titleSmall, // Replace with your title or dynamic content
          ),
          const SizedBox(height: 8.0), // Spacing between title and content
          Row(
            children: [
              Expanded(
                child: Text(
                  task.description,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff686868)),
                ),
              ),
              const SizedBox(width: 12.0), // Spacing between text and icon
              const FaIcon(
                FontAwesomeIcons.chevronRight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
