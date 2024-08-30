// import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_filter_button/CustomFilter.dart';
import 'package:devti_agro/core/widgets/date_range_picker/date_range_picker.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/Checklist/presontation/bloc/check_list_bloc.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/create_Checklist.dart';
import 'package:devti_agro/features/Checklist/presontation/widgets/check_list_filter_helper.dart';
// packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';

import '../widgets/Checklist_card.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late CheckListFilterHelper checkListFilterHelper;

  @override
  void initState() {
    super.initState();
    checkListFilterHelper = CheckListFilterHelper(context);
  }

  @override
  Widget build(BuildContext context) {
    void onDateRangeSelected(DateTimeRange dateRange) {
      context.read<CheckListBloc>().add(FilterCheckListByDateRangeEvent(dateRange: dateRange));
    }

    return Scaffold(
      appBar: CustomAppbar(
        isShowLogin: false,
        elevation: 1,
        title: "Checklist",
        trailingIcon: const FaIcon(
          FontAwesomeIcons.circlePlus,
          color: Colors.black,
          size: 30,
        ),
        trailingAction: () {
          // GoRouter.of(context).pushNamed(AppRoutes.checklistCreate);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateChecklist()), // Replace NextPage with your target page
          );
        },
      ),
      drawer: const CustomDrawer(
        currentRoute: "Checklist",
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CheckListBloc>().add(RefreshCkeckListEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchBar(
                  onSearchChanged: (searchText) {
                    context.read<CheckListBloc>().add(SearchCheckListEvent(searchText));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomFilter(
                      filterAction: () => checkListFilterHelper.openFilterSheet(), // Use the helper class
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DateRangePicker(
                        onDateRangeSelected: onDateRangeSelected,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              BlocBuilder<CheckListBloc, CheckListState>(
                builder: (context, state) {
                  // print('Current state: $state'); // Log the current state

                  if (state is LoadingCheckListState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoadedCheckListState) {
                    final checkLists = state.checkList;
                    if (checkLists.isEmpty) {
                      return const Center(child: Text('No data available.'));
                    }
                    return Column(
                      children: checkLists.map((checkList) {
                        return ChecklistCard(checkList: checkList);
                      }).toList(),
                    );
                  } else if (state is ErrorCheckListState) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Center(child: Text('Unexpected state: $state'));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
