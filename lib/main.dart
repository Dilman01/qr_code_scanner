import 'package:flutter/material.dart';
import 'package:qr_code_scanner/screens/onboadring_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showHome});

  final bool showHome;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: showHome ? MyHome() : const OnboardingScreen(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My Home'),
      ),
    );
  }
}
