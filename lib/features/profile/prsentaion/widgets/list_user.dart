import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListUser extends StatelessWidget {
  const ListUser({super.key});

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
          title: const Text(
            'John Doe',
            style: TextStyle(color: Colors.black),
          ),
          subtitle: const Text('johndoe@gmail.com'),
          trailing: const FaIcon(FontAwesomeIcons.circleArrowRight),
        ));
  }
}
