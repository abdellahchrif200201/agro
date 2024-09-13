import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/features/overview/presontaion/pages/overview.dart';
import 'package:devti_agro/features/user/aplication/bloc/bloc/show_user_bloc.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Adjust the import path as necessary

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> menu = ["Overview", "products", "Temperature", "Tasks"];
  String _currentPage = "Overview"; // Default page
  String _selectedMenu = "Overview"; // Default selected menu item

  Widget _getPageContent(String page) {
    switch (page) {
      case "Overview":
        return const OverViewTabView();
      case "products":
        return const Center(child: Text("Temperature Page Content", style: TextStyle(fontSize: 24)));
      case "Temperature":
        return const Center(child: Text("Temperature Page Content", style: TextStyle(fontSize: 24)));
      case "Tasks":
        return const Center(child: Text("Tasks Page Content", style: TextStyle(fontSize: 24)));
      default:
        return const Center(child: Text("Page not found", style: TextStyle(fontSize: 24)));
    }
  }

  String? token; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('auth_token');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;
    context.read<ShowUserBloc>().add(FetchUserEvent(69));
    return Scaffold(
      appBar: CustomAppbar(
        title: "Dashboard",
        elevation: 0,
        isShowLogin: token != null ? false : true,
      ), // Use MyAppbar
      drawer: const CustomDrawer(
        currentRoute: "overview",
      ), // Use the new CustomDrawer widget
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeBloc ? const Color(0xff000000) : const Color(0xffFAFAFA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final item = menu[index];
                final isSelected = _selectedMenu == item;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPage = item; // Update the current page
                      _selectedMenu = item; // Update the selected menu
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      // Change color based on selection
                      color: isSelected
                          ? themeBloc
                              ? containerBlack
                              : containerWhite
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected ? Border.all(color: themeBloc ? Colors.white : Colors.black) : null, // Add border if selected
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: themeBloc ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _getPageContent(_currentPage), // Display content based on current page
          ),
        ],
      ),
    );
  }
}
