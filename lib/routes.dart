import 'package:flutter/material.dart';
import 'modules/id_card/id_card_screen.dart';
import 'modules/id_card/id_card_model.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/staff/staff_dashboard.dart';
import 'screens/student/student_dashboard.dart';

class AppRoutes {
  static const String login = '/';
  static const String forgotPassword = '/forgot-password';
  static const String staffDashboard = '/staff-dashboard';
  static const String studentDashboard = '/student-dashboard';
  static const String idCard = '/id-card';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case staffDashboard:
        return MaterialPageRoute(
          builder: (_) => const StaffDashboard(),
        );
      case studentDashboard:
        return MaterialPageRoute(
          builder: (_) => const StudentDashboard(),
        );
      case idCard:
        final idCard = settings.arguments as IdCard;
        return MaterialPageRoute(
          builder: (_) => IdCardScreen(idCard: idCard),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}