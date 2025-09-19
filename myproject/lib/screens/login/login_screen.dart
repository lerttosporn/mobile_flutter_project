import 'package:flutter/material.dart';
import 'package:myproject/components/responsive_layout.dart';
import 'package:myproject/components/web_layout.dart';
import 'package:myproject/screens/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: WebLayout(
        imageWidget: Image.asset(
          "../../assets/images/login.png",
          width: 75,
        ),
        dataWidget: LoginForm(),
      ),
      tabletBody: WebLayout(
        imageWidget: Image.asset(
          "../../assets/images/login.png",
          width: 200,
        ),
        dataWidget: LoginForm(),
      ),
    );
  }
}