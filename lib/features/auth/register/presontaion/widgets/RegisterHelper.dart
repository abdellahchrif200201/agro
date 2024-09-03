import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/bloc/register_bloc.dart';

class RegisterHelper {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController entrepriseICEController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController countryController;
  final TextEditingController nameController;
  final TextEditingController emailController;

  RegisterHelper({
    required this.context,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.entrepriseICEController,
    required this.phoneController,
    required this.addressController,
    required this.countryController,
    required this.nameController,
    required this.emailController,
  });

  void register() {
    if (formKey.currentState?.validate() ?? false) {
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;
      final int? entrepriseICE = int.tryParse(entrepriseICEController.text);
      final int? phone = int.tryParse(phoneController.text);

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      if (entrepriseICE == null || phone == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid numbers")),
        );
        return;
      }

      // Trigger registration event or logic here
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          name: nameController.text,
          entrepriseICE: entrepriseICE,
          email: emailController.text,
          password: password,
          phone: phone,
          address: addressController.text,
          country: countryController.text,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  email: emailController.text,
                  password: password,
                )),
      );
    }
  }
}
