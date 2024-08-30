import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/profile/prsentaion/widgets/list_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("all users"),
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CustomSearchBar(
                hintText: "user name..",
              ),
            ),
            ListUser(),
            ListUser(),
            ListUser(),
            ListUser(),
          ],
        ),
      ),
    );
  }
}
