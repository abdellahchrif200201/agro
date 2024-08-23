
import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatefulWidget {
  final String currentRoute;

  const CustomDrawer({Key? key, required this.currentRoute}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<Map<String, dynamic>> menu = [
    {"title": "overview", "page": AppRoutes.homePage},
    {"title": "Temperature", "page": AppRoutes.temperature},
    {"title": "Tracbalite", "page": AppRoutes.traceability},
    {"title": "Nettoyage", "page": AppRoutes.nettoyage},
    {"title": "Checklist", "page": AppRoutes.checklist},
    {"title": "Etiquetage", "page": AppRoutes.etiquetage},
    {"title": "Chambres", "page": AppRoutes.chambres},
  ]; // Menu items with corresponding pages

  int _selectedIndex = 0; // Track the selected index

  @override
  void initState() {
    super.initState();
    _selectedIndex = menu.indexWhere((item) => item['title'] == widget.currentRoute);
  }

  @override
  Widget build(BuildContext context) {
    final userProfileImage ='https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww';

    return Drawer(
      width: MediaQuery.sizeOf(context).width / 1.5,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(

                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfileImage),
                      radius: 20, // Adjust as needed
                    ),
                    const SizedBox(width: 12),
                     Text(
                      'Account Name',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_drop_down), // Replace with your custom widget
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              const Divider(height: 4 , color: Colors.black26,),
              const SizedBox(height: 28,),
              CustomSearchBar(
                hintText: 'Search...'.tr(),
              ),
              const SizedBox(height: 15,),

              // Menu items
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: menu.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> item = entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index; // Update selected index
                        });
                        Navigator.pop(context); // Close the drawer

                        context.go(item['page']); // Navigate to the selected page using GoRouter
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _selectedIndex == index ? Colors.black26 : Colors.transparent, // Only show border for selected item
                            width: 1, // Adjust width as needed
                          ),
                          color: _selectedIndex == index ? Colors.grey.withOpacity(0.2) : Colors.transparent, // Optional: Add a background color to highlight selected item
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['title'],
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: _selectedIndex == index ? Color(0xff000000) : Color(0xff565656),
                                ),
                              ),
                              if(_selectedIndex == index)
                                const FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Colors.black,

                                )
                            ],
                          ),
                        ),

                      ),
                    );

                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
