import 'package:cleanmypool/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('user_role') ?? 'customer';
  runApp(ProviderScope(child: CleanMyPoolApp(initialRole: role)));
}

class CleanMyPoolApp extends StatelessWidget {
  final String initialRole;
  const CleanMyPoolApp({super.key, required this.initialRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanMyPool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF3A86FF),
          secondary: const Color(0xFF6BA292),
          background: const Color(0xFFF8F9FA),
          surface: Colors.white,
          onPrimary: Colors.white,
          onBackground: Colors.black87,
          onSurface: Colors.black87,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontFamily: 'Inter'),
        ),
        cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/splash',
    );
  }
}