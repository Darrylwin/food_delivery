import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_text_filed.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/registration_button.dart';
import 'navigation/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

// Méthode pour créer un utilisateur
  Future<void> signUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password == confirmPassword) {
      try {
        final response = await Supabase.instance.client.auth.signUp(
          email: email, // email de l'utilisateur
          password: password, // mot de passe de l'utilisateur
        );

        if (response.error == null) {
          // Utilisateur créé avec succès, informer l'utilisateur de vérifier son email
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Utilisateur créé avec succès. Veuillez vérifier votre email pour confirmer votre compte.',
                ),
              ),
            ),
          );

          // Attendre la confirmation de l'email
          await waitForEmailConfirmation(email, password);
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Erreur : $e'),
            ),
          ),
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Passwords don\'t match'),
                ),
              ));
    }
  }

  // Méthode pour attendre la confirmation de l'email
  Future<void> waitForEmailConfirmation(String email, String password) async {
    bool isConfirmed = false;

    while (!isConfirmed) {
      await Future.delayed(const Duration(seconds: 5));

      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.error == null) {
        isConfirmed = true;
        // Rediriger vers la HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 13),
                //logo
            
                Center(
                  child: Image.asset(
                    'assets/images/nom.png',
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // app welcome message
                const Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // email textfield
                MyTextFiled(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
            
                const SizedBox(height: 33),
            
                //password textfield
                MyTextFiled(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
            
                const SizedBox(height: 33),
            
                // confirm password textfield
                MyTextFiled(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
            
                const SizedBox(height: 33),
            
                // sign up button
                MyButton(
                  onTap: signUp,
                  text: "SIGN UP",
                ),
            
                const SizedBox(height: 19),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegistrationButton(
                      image: 'assets/icons/facebook.png',
                      onTap: () {},
                    ),
                    RegistrationButton(
                      image: 'assets/icons/google.png',
                      onTap: () {},
                    ),
                  ],
                ),
            
                const SizedBox(height: 10),
            
                // already havea an account ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          color: Color(0xff0d5ef9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}
