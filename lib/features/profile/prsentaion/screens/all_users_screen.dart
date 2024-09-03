import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/list_user.dart';
import 'package:devti_agro/features/user/aplication/bloc/add_role_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("all users"),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomSearchBar(
                hintText: "user name..",
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is LoadingUserState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("loading.."),
                        LoadingAnimationWidget.newtonCradle(
                          color: Color.fromARGB(255, 13, 200, 63),
                          size: 30,
                        ),
                      ],
                    ),
                  );
                } else if (state is LoadedUserState) {
                  final users = state.users;
                  if (users.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  }
                  return Column(
                    children: users.map((user) {
                      return ListUser(user: user);
                    }).toList(),
                  );
                } else if (state is ErrorUserState) {
                  return RefreshData(
                    onPressed: () => context.read<UserBloc>().add(GetAllUserEvent()),
                  );
                }

                return const Center(child: Text("loading ..."));
              },
            ),
          ],
        ),
      ),
    );
  }
}
