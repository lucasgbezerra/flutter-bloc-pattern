import 'package:bloc_pattern/view/pages/todo_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Pattern',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoPage(),
    );
  }
}