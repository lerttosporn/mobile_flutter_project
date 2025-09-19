import 'package:myproject/screens/login/login_screen.dart';
import 'package:myproject/screens/welcome/welcome_screen.dart';

class AppRouter {
  //Routeer Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';

  static get routes => {
        welcome: (context) => const WelcomeScreen(),
        login: (context) => const LoginScreen(),
      };
}