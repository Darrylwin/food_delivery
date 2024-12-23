import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_text_filed.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login method

  Future<void> logIn() async {
    // authentification
    // Récupérez les valeurs des champs de texte
    String email = emailController.text;
    String password = passwordController.text;
          

    // Affichez les valeurs pour vérification (vous pouvez les envoyer à un serveur ici)
    print('Email: $email');
    print('Password: $password');

     try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.error == null) {
        // Connexion réussie
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion réussie')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Affichage d'une erreur si la connexion échoue
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur : ${response.error!.message}'),
        ));
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            "Welcome back ! Let's Log In",
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

          // sign in button
          MyButton(
            onTap: logIn,
            text: "Sign In",
          ),

          const SizedBox(
            height: 25,
          ),

          // not a member ? register now

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member ?",
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
                  "Register Now",
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
    );
  }
}

extension on AuthResponse {
  get error => null;
}
