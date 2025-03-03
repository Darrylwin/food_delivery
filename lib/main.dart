import 'package:flutter/material.dart';
import 'package:food_delivery/backend/supabase_config.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/pages/navigation/home_page.dart';
import 'package:food_delivery/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';
import 'models/location_model.dart';
import 'models/restaurant.dart';
import 'services/notifications/notif_service.dart';
import 'services/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotifService().initNotifiaction();
  await SupabaseConfig.initialize();
  await LocationModel().initializeLocation();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Restaurant()),
        ChangeNotifierProvider(create: (context) => MyNotification()),
        ChangeNotifierProvider(create: (context) => LocationModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
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
      // theme: ThemeData(
      //   scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      //   canvasColor: const Color(0xFFF5F5F5),
      //   colorScheme: ColorScheme.light(
      //     surface: Colors.grey.shade300,
      //     primary: Colors.grey.shade500,
      //     secondary: Colors.grey.shade100,
      //     tertiary: Colors.white,
      //     inversePrimary: Colors.grey.shade700,
      //   ),
      // ),
      theme: context.watch<ThemeProvider>().currentTheme,
      home: const HomePage(),
    );
  }
}
