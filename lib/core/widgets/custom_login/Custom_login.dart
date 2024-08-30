import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomLogin extends StatelessWidget {
  const CustomLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xff059212))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "se connecter",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400, color: Color(0xff059212)),
            ),
            Icon(
              Ionicons.log_in_outline,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
