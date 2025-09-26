import 'package:cleanmypool/features/auth/auth_screen.dart';
import 'package:cleanmypool/features/customer/home/home_screen.dart';
import 'package:cleanmypool/features/cleaner/dashboard/dashboard_screen.dart';
import 'package:cleanmypool/features/admin/admin_shell.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen(initialRole: settings.arguments as String? ?? 'customer'));
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen(isCleaner: settings.arguments as bool? ?? false));
      case '/customer/home':
        return MaterialPageRoute(builder: (_) => const CustomerHomeScreen());
      case '/cleaner/dashboard':
        return MaterialPageRoute(builder: (_) => const CleanerDashboardScreen());
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminShell());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page Not Found'))));
    }
  }
}

class SplashScreen extends StatefulWidget {
  final String initialRole;
  const SplashScreen({super.key, required this.initialRole});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role') ?? widget.initialRole;

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        role == 'cleaner' ? '/cleaner/dashboard' : '/customer/home',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pool, size: 80, color: Color(0xFF3A86FF)),
            SizedBox(height: 16),
            Text('CleanMyPool', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}