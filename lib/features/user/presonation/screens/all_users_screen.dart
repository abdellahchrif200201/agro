import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/core/widgets/custom_refresh_error/refresh_data_in_dropDown.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
// import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/list_user.dart';
import 'package:devti_agro/features/user/aplication/bloc/get_user_bloc/user_bloc.dart';
import 'package:devti_agro/generated/l10n.dart';
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
        title: const Text(
          "all users",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        // flexibleSpace: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Ionicons.chevron_back_outline,
        //     color: Theme.of(context).iconTheme.color,
        //   ),
        // ),
        leadingWidth: 80,
      ),
      drawer: CustomDrawer(
        currentRoute: S.of(context).all_user,
      ),
      // floatingActionButton: Container(
      //   width: 100,
      //   height: 100,
      //   color: Colors.green,
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserBloc>().add(RefreshUserEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomSearchBar(
                          onSearchChanged: (searchText) {
                            context.read<UserBloc>().add(SearchUserEvent(searchText));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Optional: add some space between the TextField and Container
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => const AddUserScreen()));
                      },
                      child: Container(
                        height: 47,
                        width: 47,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Ionicons.add_circle,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<UserBloc>().add(RefreshUserEvent());
                      },
                      child: Container(
                        height: 47,
                        width: 47,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is LoadingUserState) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.green,
                          rightDotColor: Colors.purple,
                          size: 30,
                        ),
                      ],
                    );
                  } else if (state is LoadedUserState) {
                    final users = state.users;
                    if (users.isEmpty) {
                      return const Center(child: Text('No data available.'));
                    }
                    return Column(
                      children: [
                        Column(
                          children: users.map((user) {
                            return ListUser(user: user);
                          }).toList(),
                        ),
                        // Row(
                        //   children: [
                        //     Text(users.first.pageFrom.toString()),
                        //   ],
                        // )
                      ],
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
      ),
    );
  }
}
