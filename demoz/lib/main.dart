import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/onboarding_screen.dart';
import 'features/auth/presentation/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demoz Payroll',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF579AFC)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const Scaffold(body: Center(child: Text('Login Screen - Coming Soon'))),
        '/signup': (context) => const SignupScreen(),
      },
    );
  }
}
