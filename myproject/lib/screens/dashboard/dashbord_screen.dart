import 'package:flutter/material.dart';
import 'package:myproject/screens/bottomnavpage/home_screen.dart';
import 'package:myproject/screens/bottomnavpage/notification_screen.dart';
import 'package:myproject/screens/bottomnavpage/profile_screen.dart';
import 'package:myproject/screens/bottomnavpage/report_screen.dart';
import 'package:myproject/screens/bottomnavpage/setting_screen.dart';
import 'package:myproject/themes/colors.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  //สร้าง Buttom Navigetion Bar-------------------------------------
  //เก็บ title ของแต่ละหน้า -----------------------------------------
  String _title = "FluterStroe";
  //เก็บ index ของแต่ละหน้า -----------------------------------------
  int _currentIndex = 0;

  //สร้างlist ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  void ontabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _title = 'Home';
          break;
        case 1:
          _title = 'Report';
          break;
        case 2:
          _title = 'Notification';
          break;
        case 3:
          _title = 'Setting';
          break;
        case 4:
          _title = 'Profile';
          break;
        default:
          _title = "FluterStroe";
      }
    });
  }

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
      appBar: AppBar(title: Text(_title)),
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
                    onTap: () => _logout(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // menu bar right side
      // endDrawer: Drawer(),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {ontabTapped(value)},
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: primaryDark,
        unselectedItemColor: primaryLight,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Report',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: 'Notification',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
