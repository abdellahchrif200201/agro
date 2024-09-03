import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:devti_agro/core/config/theme/palette.dart';
import 'package:devti_agro/core/widgets/custom_login/Custom_login.dart';
import 'package:devti_agro/core/widgets/search_bar.dart/custom_search_bar.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/check_list_screen.dart';
import 'package:devti_agro/features/Nettoyage/Nettoyage_screen.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/screens/Tracbalite_screen.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/chambre_screen.dart';
import 'package:devti_agro/features/dashboard/HomePage.dart';
import 'package:devti_agro/features/nutrition/presentaion/screens/nutrition_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/account_screen.dart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/Etiquetage/presontation/screens/Etiquetage_screen.dart';

class CustomDrawer extends StatefulWidget {
  final String currentRoute;

  const CustomDrawer({super.key, required this.currentRoute});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

final List<Map<String, dynamic>> menu = [
  {"title": "overview", "page": const Homepage()},
  {"title": "Nutrition", "page": const NutritionScreen()},
  {"title": "Tracbalite", "page": const TracbaliteScreen()},
  {"title": "Nettoyage", "page": const NettoyageScreen()},
  {"title": "Checklist", "page": const ChecklistScreen()},
  {"title": "Etiquetage", "page": const EtiquetageScreen()},
  {"title": "Chambres", "page": const ChambreScreen()},
];

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedIndex = 0; // Track the selected index
  String? name; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _selectedIndex = menu.indexWhere((item) => item['title'] == widget.currentRoute);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    const userProfileImage = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Drawer(
      backgroundColor: themeBloc ? Color(0xff000000) : secondaryColor,
      width: MediaQuery.sizeOf(context).width / 1.5,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              if (name == null) const CustomLogin(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.black54,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  // Attach the GlobalKey to the GestureDetector
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountScreen()),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(userProfileImage),
                        radius: 20, // Adjust as needed
                      ),
                      const SizedBox(width: 12),
                      Text(
                        name ?? 'user name',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      const FaIcon(
                        FontAwesomeIcons.circleArrowRight,
                        color: Colors.green,
                      ), // Replace with your custom widget
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 4,
                color: Colors.black26,
              ),
              const SizedBox(
                height: 28,
              ),
              CustomSearchBar(
                hintText: 'Search...'.tr(),
              ),
              const SizedBox(
                height: 15,
              ),
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

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => item['page']),
                        ); // Navigate to the selected page using GoRouter
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _selectedIndex == index ? Colors.green : Colors.transparent, // Only show border for selected item
                            width: 1, // Adjust width as needed
                          ),
                          color: _selectedIndex == index ? Colors.green.withOpacity(0.2) : Colors.transparent, // Optional: Add a background color to highlight selected item
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['title'],
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: _selectedIndex == index ? Colors.green : Color.fromARGB(255, 128, 128, 128),
                                    ),
                              ),
                              if (_selectedIndex == index)
                                const FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Colors.green,
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
