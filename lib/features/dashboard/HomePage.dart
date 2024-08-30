
import 'package:devti_agro/core/widgets/custom_appbar/Custom_appbar.dart';
import 'package:devti_agro/core/widgets/custom_drawer/custom_drawer.dart';
import 'package:devti_agro/features/overview/presontaion/pages/overview.dart';

import 'package:flutter/material.dart';
 // Adjust the import path as necessary

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> menu = ["Overview", "Analytics", "Temperature", "Tasks"];
  String _currentPage = "Overview"; // Default page
  String _selectedMenu = "Overview"; // Default selected menu item

  Widget _getPageContent(String page) {
    switch (page) {
      case "Overview":
        return const OverViewTabView();
      case "Analytics":
        return const Center(child: Text("Analytics Page Content", style: TextStyle(fontSize: 24)));
      case "Temperature":
        return const Center(child: Text("Temperature Page Content", style: TextStyle(fontSize: 24)));
      case "Tasks":
        return const Center(child: Text("Tasks Page Content", style: TextStyle(fontSize: 24)));
      default:
        return const Center(child: Text("Page not found", style: TextStyle(fontSize: 24)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: "Dashboard", elevation: 0,isShowLogin: true,), // Use MyAppbar
        drawer: const CustomDrawer(currentRoute: "overview",),  // Use the new CustomDrawer widget
      body: Column(
        children: [
          Container(

            decoration: BoxDecoration(
              color: Color(0xffFAFAFA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
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
                      color: isSelected ? Color(0xffFFFFFF) : null,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected ? Border.all(color: Colors.black26, width: 1) : null, // Add border if selected
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black
                        ),
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
