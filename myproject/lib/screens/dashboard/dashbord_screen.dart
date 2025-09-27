import 'package:flutter/material.dart';
import 'package:myproject/themes/colors.dart';

class DashbordScreen extends StatelessWidget {
  const DashbordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      // menu bar left side
      drawer: Drawer(
        backgroundColor: primaryLight,
        child: Column(
          children: [
            ListView(
              // Important: Remove any padding from the ListView.
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("Name"),
                  accountEmail: Text("Email"),
                  currentAccountPicture: CircleAvatar(),
                ),
              ],
            ),
          ],
        ),
      ),
      // menu bar right side
      // endDrawer: Drawer(),
      body: const Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
