import 'package:myproject/screens/dashboard/dashbord_screen.dart';
import 'package:myproject/screens/drawerpage/about_screen.dart';
import 'package:myproject/screens/drawerpage/contact_screen.dart';
import 'package:myproject/screens/drawerpage/info_screen.dart';
import 'package:myproject/screens/login/login_screen.dart';
import 'package:myproject/screens/register/register_screen.dart';
import 'package:myproject/screens/welcome/welcome_screen.dart';

class AppRouter {
  //Routeer Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';
  static const String info = 'info';
  static const String about = 'about';
  static const String contact = 'contact';

  static get routes => {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    dashboard:(context)=>const DashbordScreen(),
    info: (context) => const InfoScreen(),
    about: (context) => const AboutScreen(),
    contact: (context) => const ContractScreen(),
  };
}
