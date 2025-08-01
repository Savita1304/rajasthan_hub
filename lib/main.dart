import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart'; // ✅ Import your DashboardScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before Firebase init
  await Firebase.initializeApp();            // ✅ Initialize Firebase
  runApp(const RajasthanHubApp());
}

class RajasthanHubApp extends StatelessWidget {
  const RajasthanHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rajasthan Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Optional: match your Figma style
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF89655)), // Use const for Color
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(), // ✅ Add the dashboard route here
      },
    );
  }
}