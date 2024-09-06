import 'package:devti_agro/features/profile/prsentaion/screens/full_user_information.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListUser extends StatelessWidget {
  final User user;
  const ListUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: Color(0xffF5F5F5), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/avatar.png",
                    ),
                    fit: BoxFit.cover)),
          ),
          title: Text(
            user.name,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(user.email ?? "null"),
          trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullUserInformation(
                            user: user,
                          )),
                );
              },
              child: const FaIcon(FontAwesomeIcons.circleArrowRight)),
        ));
  }
}
