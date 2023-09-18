import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_app/bloc/qr_code_bloc.dart';

import 'package:qr_code_scanner_app/screens/home_screen.dart';
import 'package:qr_code_scanner_app/screens/onboadring_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
    MyApp(showHome: showHome),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showHome});

  final bool showHome;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QRCodeBloc()..add(LoadedQRCodes()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        title: 'QR Code Scanner App',
        home: showHome ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }
}
