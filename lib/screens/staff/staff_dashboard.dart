import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modules/id_card/id_card_model.dart';
import '../../routes.dart';

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge, size: 32),
              title: const Text('Virtual ID Card'),
              subtitle: const Text('View and download your digital ID'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                final idCard = IdCard(
                  id: 'EMP-12345',
                  name: 'Dr. John Smith',
                  photoUrl: 'https://example.com/staff/12345.jpg',
                  role: 'staff',
                  department: 'Computer Science',
                  expiryDate: DateTime.now().add(const Duration(days: 365)),
                  qrData: 'INSTITUTION:STAFF:12345:${DateTime.now().millisecondsSinceEpoch}',
                );
                Navigator.pushNamed(
                  context,
                  AppRoutes.idCard,
                  arguments: idCard,
                );
              },
            ),
          ),
          // Other dashboard items would go here
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Institution Portal'),
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
              // Same ID card navigation as above
            },
          ),
          // Other menu items
        ],
      ),
    );
  }
}