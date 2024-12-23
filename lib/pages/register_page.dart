import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_text_filed.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_page.dart';

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
      // Affichez les valeurs pour vérification (vous pouvez les envoyer à un serveur ici)
      print('Email: $email');
      print('Password: $password');

      try {
        final response = await Supabase.instance.client.auth.signUp(
          email: email, // email de l'utilisateur
          password: password, // mot de passe de l'utilisateur
        );

        if (response.error == null) {
          // Utilisateur créé avec succès, vous pouvez rediriger ou afficher un message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Utilisateur créé avec succès')),
          );

          // Connecter l'utilisateur
          await logUserIn(email, password);
        } else {
          // Afficher l'erreur si la création de l'utilisateur échoue
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${response.error!.message}')),
          );
        }
      } catch (e) {
        print('Erreur lors de la création de l\'utilisateur : $e');
      }
    } else {
      print('Email: $email');
      print('Password: $password');
      print('confirmPassword: $confirmPassword');
      print('Passwords don\'t match');

      // Afficher un message d'erreur si les mots de passe ne correspondent pas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords don\'t match'),
        ),
      );
    }
  }

  // Méthode pour connecter l'utilisateur
  Future<void> logUserIn(String email, String password) async {
    try {
      final loginResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (loginResponse.error == null) {
        // Rediriger vers la HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // Afficher l'erreur si la connexion échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de connexion : ${loginResponse.error!.message}')),
        );
      }
    } catch (e) {
      print('Erreur lors de la connexion de l\'utilisateur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              //logo
              Center(
                child: Icon(
                  Icons.lock_open_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),

              // app welcome message
              Text(
                "A new member ! Let's Create an account",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextFiled(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 20),

              //password textfield
              MyTextFiled(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 20,
              ),

              // confirm password textfield
              MyTextFiled(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 20,
              ),

              // sign up button
              MyButton(
                onTap: signUp,
                text: "Sign up",
              ),

              const SizedBox(
                height: 25,
              ),

              // already havea an account ?

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}
