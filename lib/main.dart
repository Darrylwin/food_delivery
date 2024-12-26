import 'package:flutter/material.dart';
import 'package:food_delivery/backend/supabase_config.dart';
import 'package:food_delivery/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';
import 'models/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => Restaurant(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginOrRegister(),
    );
  }
}
