import 'package:flutter/material.dart';
import 'package:myproject/themes/colors.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  //LogOut function------------------------------------------------
  _logout() {
    Utility.deleteSharedPreferance("token");
    Utility.deleteSharedPreferance("loginStatus");
    //Clear Screen-------------------------------------------------
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }
  //---------------------------------------------------------------

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
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/noavartar.png",
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/signup.png"),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Info'),
                  onTap: () => {Navigator.pushNamed(context, AppRouter.info)},
                ),
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('About'),
                  onTap: () => {Navigator.pushNamed(context, AppRouter.about)},
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('Contact'),
                  onTap: () => {
                    Navigator.pushNamed(context, AppRouter.contact),
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () => _logout,
                  ),
                ],
              ),
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
