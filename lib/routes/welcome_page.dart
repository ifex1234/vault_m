import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Vault')),
      body: const Center(
        child: Text('Welcome to the Vault App! Please log in or register.'),
      ),
    );
  }
}
