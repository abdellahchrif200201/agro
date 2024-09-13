import 'package:devti_agro/core/widgets/custom_button/custom_btn.dart';
import 'package:devti_agro/core/widgets/custom_rich_text/custom_rich_text.dart';
import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:devti_agro/features/auth/register/presontaion/widgets/RegisterHelper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:devti_agro/core/widgets/custom_text_field/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _entrepriseICEController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final bool _obscureText = true;
  final bool _confirmObscureText = true;
  bool isLoding = false;

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  void _nextPage() {
    if (_formKey1.currentState?.validate() ?? false) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _register() {
    setState(() {
      isLoding = true; // Set loading to true
    });

    RegisterHelper(
      context: context,
      formKey: _formKey2,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      entrepriseICEController: _entrepriseICEController,
      phoneController: _phoneController,
      addressController: _addressController,
      countryController: _countryController,
      nameController: _nameController,
      emailController: _emailController,
    ).register().then((_) {
      // Stop loading after registration logic is complete
      setState(() {
        isLoding = false;
      });
    }).catchError((error) {
      // Stop loading in case of an error
      setState(() {
        isLoding = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/test_logo.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  _buildUserInfoPage(),
                  _buildEnterpriseDetailsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Inscription",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Entrez vos informations pour créer un compte",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromARGB(139, 0, 0, 0)),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameController,
                // labelText: "Name",
                hintText: "Entrez votre nom",
                suffixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                labelText: "Email",
                hintText: "Entrez votre email",
                suffixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                labelText: "Mot de passe",
                hintText: "Entrez votre Mot de passe",
                obscureText: _obscureText,
                suffixIcon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: "Confirmez le mot de passe",
                hintText: "Ressaisissez votre mot de passe",
                obscureText: _confirmObscureText,
                suffixIcon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              const SizedBox(height: 100),
              CustomButton(
                  onPressed: _nextPage,
                  text: "Page suivante",
                  backgroundColor: Colors.green,
                  child: isLoding
                      ? LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF1A1A3F),
                          rightDotColor: const Color(0xFFEA3799),
                          size: 30,
                        )
                      : null),
              const SizedBox(height: 100),
              CustomRichText(
                onPressed: () {
                  // Navigate to the registration page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                spanText: "Connexion",
                text: "Vous avez déjà un compte ?",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnterpriseDetailsPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Inscription",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Entrez vos informations pour créer un compte",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromARGB(139, 0, 0, 0)),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _entrepriseICEController,
                labelText: "Entreprise ICE",
                hintText: "Entrez votre entreprise ICE",
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.toc),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _phoneController,
                labelText: "Numéro de téléphone",
                hintText: "Entrez votre numéro de téléphone",
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _addressController,
                labelText: "Adresse",
                hintText: "Entrez votre adresse",
                suffixIcon: const Icon(Icons.location_on),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _countryController,
                labelText: "Pays",
                hintText: "Entrez votre pays",
                suffixIcon: const Icon(Icons.flag),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _register,
                isRun: false,
                text: "Inscription",
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 100),
              CustomRichText(
                onPressed: () {
                  // Navigate to the registration page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                spanText: "Connexion",
                text: "Vous avez déjà un compte ?",
              )
            ],
          ),
        ),
      ),
    );
  }
}
