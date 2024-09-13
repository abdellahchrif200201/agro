import 'package:devti_agro/features/profile/prsentaion/screens/full_user_information.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListUser extends StatelessWidget {
  final User user;
  const ListUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullUserInformation(
                    user: user,
                  )),
        );
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 229, 230, 227),
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.green, // Shadow color with opacity
            //     blurRadius: 2, // How much the shadow should spread
            //     offset: Offset(0, 2), // Shadow offset
            //   ),
            // ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(),
                      image: const DecorationImage(
                          image: AssetImage(
                            "assets/images/avatar.png",
                          ),
                          fit: BoxFit.cover)),
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(color: Colors.black),
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
              ),
              const SizedBox(
                height: 10,
              ),
              // UserCard(
              //   label: "Country",
              //   value: user.pays ?? "morooco",
              // ),
              // UserCard(
              //   label: "address",
              //   value: user.adresse ?? "tangier tech10",
              // ),
              // UserCard(
              //   label: "City",
              //   value: user.ville ?? "tangier",
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Container(
              //         padding: const EdgeInsets.symmetric(vertical: 5),
              //         width: 40,
              //         margin: const EdgeInsets.all(2),
              //         decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
              //         child: const Center(
              //             child: Icon(
              //           Icons.delete,
              //           color: Colors.white,
              //         )),
              //       ),
              //       Container(
              //         padding: const EdgeInsets.symmetric(vertical: 5),
              //         width: 40,
              //         margin: const EdgeInsets.all(2),
              //         decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              //         child: const Center(
              //             child: Icon(
              //           Icons.edit,
              //           color: Colors.white,
              //         )),
              //       )
              //     ],
              //   ),
              // )
            ],
          )),
    );
  }
}

// class UserCard extends StatelessWidget {
//   final String label;
//   final String value;
//   const UserCard({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           const Divider(
//             color: Colors.black,
//             height: 3,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.blue))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
