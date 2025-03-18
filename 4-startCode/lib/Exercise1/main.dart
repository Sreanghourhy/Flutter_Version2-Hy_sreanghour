import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/courses_provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseProvider(),
      child: MaterialApp(title: 'Score App', home: const CourseListScreen()),
    );
  }
}
