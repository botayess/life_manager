import 'package:flutter/material.dart';

void main() {
  runApp(const LifeManagerApp());
}

class LifeManagerApp extends StatelessWidget {
  const LifeManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Manager',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Life Manager"),
      ),
      body: const Center(
        child: Text(
          "Life Manager project started!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}