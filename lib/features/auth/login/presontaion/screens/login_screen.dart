import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:devti_agro/features/auth/login/aplication/bloc/login_bloc.dart';
import 'package:devti_agro/features/auth/register/presontaion/screens/register_screen.dart';
import 'package:devti_agro/features/dashboard/HomePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  final String? password;
  const LoginScreen({super.key, this.email, this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _obscureText = false;

  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email ?? "";
    passwordController.text = widget.password ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  setState(() {
                    isLoading = false;
                  });
                }
                if (state is LoginSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Enter your email and password below to login to your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 80),
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      hintText: "Enter your email",
                      suffixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscureText: true,
                      suffixIcon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Sign in with Email",
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<LoginBloc>().add(
                              LoginButtonPressed(email: email, password: password),
                            );
                      },
                      child: isLoading
                          ? LoadingAnimationWidget.twistingDots(
                              leftDotColor: const Color(0xFF1A1A3F),
                              rightDotColor: const Color(0xFFEA3799),
                              size: 30,
                            )
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR CONTINUE WITH",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xff616161),
                                  fontSize: 11,
                                ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      text: "Google",
                      textColor: Colors.black,
                      border: true,
                      onPressed: () {
                        // Handle Google sign-in
                      },
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.google, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the registration page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                      text: "conextion en tant qu invite",
                      textColor: Colors.green,
                      borderColor: Colors.green,
                      border: true,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                      },
                      backgroundColor: Colors.white,
                      child: FaIcon(FontAwesomeIcons.circleChevronRight, color: Colors.green),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
