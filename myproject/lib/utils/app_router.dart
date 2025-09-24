import 'package:myproject/screens/login/login_screen.dart';
import 'package:myproject/screens/register/register_screen.dart';
import 'package:myproject/screens/welcome/welcome_screen.dart';

class AppRouter {
  //Routeer Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';

  static get routes => {
        welcome: (context) => const WelcomeScreen(),
        login: (context) => const LoginScreen(),
        register:(context)=> const RegisterScreen(),
      };
}