import 'package:devti_agro/core/utils/token_utils.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/features/overview/domain/entities/task.dart';
import 'package:devti_agro/features/overview/presontaion/bloc/tasks_bloc.dart';
import 'package:devti_agro/features/overview/presontaion/widgets/StatisticCard.dart';
import 'package:devti_agro/features/overview/presontaion/widgets/tasks_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/StatsChartGraph.dart';

class OverViewTabView extends StatefulWidget {
  const OverViewTabView({super.key});

  @override
  State<OverViewTabView> createState() => _OverViewTabViewState();
}

class _OverViewTabViewState extends State<OverViewTabView> {
  late bool isTokenAvailable = false; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    checkTokenAvailability();
  }

  Future<void> checkTokenAvailability() async {
    isTokenAvailable = await isTokenPresent();
    setState(() {}); // Update the state after async operation
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DateRangePicker(
            onDateRangeSelected: (p0) => null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatisticCard(
                title: "Tâches réalisées",
                value: "+20.1",
                index: 1,
                child: Text(
                  "158",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19),
                ),
              ),
              StatisticCard(
                title: "Température",
                value: "-30.1",
                index: 2,
                child: Text(
                  "11°C",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19),
                ),
              ),
              StatisticCard(
                title: "Traçabilité",
                value: "+20.1",
                index: 4,
                child: Text(
                  "45",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19),
                ),
              ),
              StatisticCard(
                title: "Étiquetage",
                value: "+20.1",
                index: 4,
                child: Text(
                  "25",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const StatsChartGraph(),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dernières tâches", style: Theme.of(context).textTheme.labelMedium),
                Text(
                  "Vous avez des tâches à accomplir",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff686868),
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isTokenAvailable
              ? BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, state) {
                    if (state is LoadingTasksState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LoadedTasksState) {
                      final tasks = state.tasks;
                      return Column(
                        children: tasks.map((task) {
                          return TasksCard(task: task);
                        }).toList(),
                      );
                    } else if (state is ErrorTasksState) {
                      return Center(child: Text("Failed to load tasks"));
                    } else {
                      return const SizedBox(); // Placeholder if no tasks state
                    }
                  },
                )
              : Column(
                  children: [
                    TasksCard(task: Tasks(id: 1, taskName: "taskName", status: "status", message: "message", description: "description")),
                    TasksCard(task: Tasks(id: 1, taskName: "taskName", status: "status", message: "message", description: "description")),
                  ],
                )
        ],
      ),
    );
  }
}
