import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_drawer_tile.dart';
import 'package:food_delivery/pages/settings_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth/login_or_register.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future<void> signUserOut(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();

      // Navigate to login page and clear navigation stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginOrRegister(),
        ),
        (route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing out'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      elevation: 10,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'assets/images/nom.png',
              height: 80,
              width: 80,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          // home list tile
          MyDrawerTile(
            text: 'HOME',
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),

          // settings list tile
          MyDrawerTile(
            text: 'SETTINGS',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),

          const Spacer(),

          // logout list tile
          MyDrawerTile(
            text: 'LOG OUT',
            icon: Icons.logout,
            onTap: () => signUserOut(context),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
