import 'package:flutter/material.dart';
import 'views/admin/dashboard_screen.dart';

void main() {
  runApp(const NahamApp());
}

class NahamApp extends StatelessWidget {
  const NahamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminDashboardScreen(),
    );
  }
} 