import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/initial_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokenator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/quiz': (context) => QuizScreen(),
        '/initial_screen': (context) => InitialScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
