import 'package:cleanmypool/core/router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final bool isCleaner;
  const LoginScreen({super.key, this.isCleaner = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${isCleaner ? 'Cleaner' : ''} Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16),
            TextField(decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('user_role', isCleaner ? 'cleaner' : 'customer');
                Navigator.pushReplacementNamed(context, isCleaner ? '/cleaner/dashboard' : '/customer/home');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}