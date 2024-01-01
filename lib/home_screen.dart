import 'package:flutter/material.dart';
import 'package:riverpod_demo_project/counter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CounterScreen())
            );
          },
          child: const Text("Go to counter"),
        ),
      ),
    );
  }
}
