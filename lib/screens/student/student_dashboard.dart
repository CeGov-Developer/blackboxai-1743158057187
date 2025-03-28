import 'package:flutter/material.dart';
import '../../modules/id_card/id_card_model.dart';
import '../../routes.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to student profile
            },
          ),
        ],
      ),
      drawer: const AppDrawer(isStaff: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge, size: 32),
              title: const Text('Student ID Card'),
              subtitle: const Text('Access your digital student ID'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                final idCard = IdCard(
                  id: 'STU-2023001',
                  name: 'Alex Johnson',
                  photoUrl: 'https://example.com/students/2023001.jpg',
                  role: 'student',
                  department: 'Computer Science',
                  expiryDate: DateTime.now().add(const Duration(days: 365)),
                  qrData: 'INSTITUTION:STUDENT:2023001:${DateTime.now().millisecondsSinceEpoch}',
                );
                Navigator.pushNamed(
                  context,
                  AppRoutes.idCard,
                  arguments: idCard,
                );
              },
            ),
          ),
          // Other student-specific dashboard items
          Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Academic Records'),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Class Schedule'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final bool isStaff;

  const AppDrawer({super.key, required this.isStaff});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Student Portal'),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('ID Card'),
            onTap: () {
              // ID card navigation
            },
          ),
          if (!isStaff) ...[
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Courses'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Assignments'),
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }
}