import 'package:flutter/material.dart';
import 'package:food_delivery/backend/supabase_config.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/services/auth/login_or_register.dart';
import 'package:provider/provider.dart';
import 'models/location_model.dart';
import 'models/restaurant.dart';
import 'services/notifications/notif_service.dart';
import 'services/theme/theme_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await NotifService().initNotifiaction();
  await SupabaseConfig.initialize();
  // await LocationModel().initializeLocation();

  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Restaurant()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
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
      theme: context.watch<ThemeProvider>().currentTheme,
      home: const LoginOrRegister(),
    );
  }
}
