import 'package:flutter/material.dart';
import 'package:flutter2_assignment/screens/ride_pref/test_screen.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        // body: TestScreen(),
        body: RidePrefScreen(),
      ),
    );
  }
}
