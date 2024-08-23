import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff424242),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height -100,

            decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),

                const Text(
                  "Create an accont",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500 ,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your email below to create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400 ,
                  ),
                ),
                const SizedBox(height: 80),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login in with Email" , style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                 Row(
                  children:  [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR CONTINUE WITH" ,  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Color(0xff616161),
                        fontSize: 11
                      )),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 50),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       FaIcon(FontAwesomeIcons.google),
                      SizedBox(width: 20,),
                      Text("Google" ,  style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
