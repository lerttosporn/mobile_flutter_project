import 'package:flutter/material.dart';
import 'package:myproject/l10n/app_localizations.dart';
import 'package:myproject/providers/locale_provider.dart';
import 'package:myproject/providers/theme_provider.dart';
import 'package:myproject/providers/user_provider.dart';
import 'package:myproject/themes/colors.dart';
import 'package:myproject/themes/style.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildHeader(),
          _buildListMenu(),
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: provider.isDark,
                    onChanged: (value) {
                      provider.setTheme(
                        value ? AppTheme.darkTheme : AppTheme.lightTheme,
                      );
                    },
                  ),
                  Text(provider.isDark ? 'Dark Mode' : 'Light Mode'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // สร้าง widget สำหรับแสดงข้อมูล profile ที่อ่านมาจาก shared preference
  Widget _buildHeader() {
    return Consumer2<UserProvider,ThemeProvider>(
      builder: (context, provider,theme, child) {
        final user = provider.user;
        final firstName = user?['firstName'] ?? '';
        final lastName = user?['lastName'] ?? '';
        final email = user?['email'] ?? '';
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color:
                theme.isDark ? primaryText :primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.hello,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/noavartar.png'),
              ),
              const SizedBox(height: 10),
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '$email',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  // สร้าง widget สำหรับแสดงรายการเมนูต่างๆ
  Widget _buildListMenu() {
    void logout() {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.logout(context);
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.menu_account),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: Text(AppLocalizations.of(context)!.menu_changepass),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.menu_changelang),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Create alert dialog select language
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.menu_changelang),
                  content: SingleChildScrollView(
                    child: Consumer<LocaleProvider>(
                      builder: (context, provider, child) {
                        return ListBody(
                          children: [
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('English'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('en'));
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('ไทย'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('th'));
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('中國人'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLocale(const Locale('zh'));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.menu_setting),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text(AppLocalizations.of(context)!.menu_logout),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: logout,
        ),
      ],
    );
  }
}
