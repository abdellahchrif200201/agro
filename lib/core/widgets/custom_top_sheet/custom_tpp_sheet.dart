import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopSheetRoute extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return const SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child:  Align(
          alignment: Alignment.topCenter,
          child: _TopSheetContent(),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }
}

class _TopSheetContent extends StatelessWidget {
  const _TopSheetContent({Key? key}) : super(key: key);

  Future<void> _loadUserData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("auth_token");
    prefs.remove("name");

    // Navigate to login or another screen after logout
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              // Handle the settings tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              _loadUserData(context); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}
