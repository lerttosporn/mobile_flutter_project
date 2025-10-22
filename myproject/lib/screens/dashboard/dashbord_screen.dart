import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myproject/l10n/app_localizations.dart';
import 'package:myproject/providers/theme_provider.dart';
import 'package:myproject/providers/user_provider.dart';
import 'package:myproject/screens/bottomnavpage/home_screen.dart';
import 'package:myproject/screens/bottomnavpage/notification_screen.dart';
import 'package:myproject/screens/bottomnavpage/profile_screen.dart';
import 'package:myproject/screens/bottomnavpage/report_screen.dart';
import 'package:myproject/screens/bottomnavpage/setting_screen.dart';
import 'package:myproject/themes/colors.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';
import 'package:provider/provider.dart';

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
          _title = AppLocalizations.of(context)!.menu_home;
          break;
        case 1:
          _title = AppLocalizations.of(context)!.menu_report;
          break;
        case 2:
          _title = AppLocalizations.of(context)!.menu_notification;
          break;
        case 3:
          _title = AppLocalizations.of(context)!.menu_setting;
          break;
        case 4:
          _title = AppLocalizations.of(context)!.menu_profile;
          break;
        default:
          _title = "FluterStroe";
      }
    });
  }

  // String? _firstname, _lastname, _email;
  // Map<String, dynamic>? _user;
  // getUerProfile() async {
  //   // var firstname = await Utility.getSharedPreferance("firstname");
  //   // var lastname = await Utility.getSharedPreferance("lastname");
  //   // var email = await Utility.getSharedPreferance("email");
  //   var user = await Utility.getSharedPreferance("user");
  //   // Utility.logger.i("User Info : ${jsonDecode(user)}");

  //   setState(() {
  //     _user = jsonDecode(user);
  //     // _firstname = firstname;
  //     // _lastname = lastname;
  //     // _email = email;
  //   });
  // }

  // //LogOut function------------------------------------------------
  // _logout() {
  //   Utility.deleteSharedPreferance("token");
  //   Utility.deleteSharedPreferance("loginStatus");
  //   //Clear Screen-------------------------------------------------
  //   Navigator.pushNamedAndRemoveUntil(
  //     context,
  //     AppRouter.login,
  //     (route) => false,
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getUerProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    // final user = userProvider.user;
      final themeProvider = context.watch<ThemeProvider>(); 

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      // menu bar left side
      drawer: Drawer(
      backgroundColor: themeProvider.isDark ? primaryText : primaryLight, 
        child: Column(
          children: [
            ListView(
              // Important: Remove any padding from the ListView.
              shrinkWrap: true,
              children: [
                Consumer2<UserProvider, ThemeProvider>(
                  builder:
                      (
                        BuildContext context,
                        UserProvider value,
                        ThemeProvider theme,
                        Widget? child,
                      ) {
                        final user = value.user;
                        return
                        // return UserAccountsDrawerHeader(
                        //   accountName: Text(
                        //     "${user?["firstname"] ?? 'no info'} ${user?["lastname"] ?? 'no info'}",
                        //   ),
                        //   accountEmail: Text("${user?["email"] ?? ''}"),
                        //   currentAccountPicture: CircleAvatar(
                        //     backgroundImage: AssetImage(
                        //       "assets/images/user.jpg",
                        //     ),
                        //   ),
                        //   otherAccountsPictures: const [
                        //     CircleAvatar(
                        //       backgroundImage: AssetImage(
                        //         "assets/images/noavartar.png",
                        //       ),
                        //     ),
                        //     CircleAvatar(
                        //       backgroundImage: AssetImage(
                        //         "assets/images/signup.png",
                        //       ),
                        //     ),
                        //   ],
                        UserAccountsDrawerHeader(
                          margin: EdgeInsets.only(bottom: 0.0),
                          accountName: Text(
                            "${user?["firstname"] ?? 'no info'} ${user?["lastname"] ?? 'no info'}",
                          ),
                          accountEmail: Text("${user?["email"] ?? ''}"),
                          decoration: BoxDecoration(
                            color: theme.isDark ? primaryText : primary,
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/noavartar.png',
                            ),
                          ),
                          otherAccountsPictures: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/noavartar.png',
                              ),
                            ),
                          ],
                        );
                      },
                ),

                ListTile(
                  leading: Icon(Icons.info_outline, color: icons),
                  title: Text(
                    AppLocalizations.of(context)!.menu_info,
                    style: TextStyle(color: icons),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_outline, color: icons),
                  title: Text(
                    AppLocalizations.of(context)!.menu_about,
                    style: TextStyle(color: icons),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined, color: icons),
                  title: Text(
                    AppLocalizations.of(context)!.menu_contact,
                    style: TextStyle(color: icons),
                  ),
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
                    leading: Icon(Icons.exit_to_app_outlined, color: icons),
                    title: Text(
                      AppLocalizations.of(context)!.menu_logout,
                      style: TextStyle(color: icons),
                    ),
                    onTap: () => userProvider.logout(context),
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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: primaryLight,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.menu_setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile,
          ),
        ],
      ),
    );
  }
}
