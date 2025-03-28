import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/staff/staff_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Institution Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        cardColor: Colors.grey[900],
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      home: const StaffDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}