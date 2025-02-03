import 'package:supabase_flutter/supabase_flutter.dart';
class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://rudocouhbcmsplaqoqde.supabase.co', // Remplacez par l'URL de votre projet Supabase
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ1ZG9jb3VoYmNtc3BsYXFvcWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ4MTQwMDcsImV4cCI6MjA1MDM5MDAwN30.6153g_Zd9AKPWj4RSTE_7ekZkPm8J8U6xRENA8n6Pp8',  // Remplacez par la clé d'API Anonyme
    );
  }
}
