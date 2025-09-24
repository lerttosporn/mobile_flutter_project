import 'package:flutter/material.dart';
import 'package:myproject/components/responsive_layout.dart';
import 'package:myproject/components/web_layout.dart';
import 'package:myproject/screens/register/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: WebLayout(
        imageWidget: Image.asset(
          "../../assets/images/login.png",
          width: 75,
        ),
        dataWidget: RegisterForm(),
      ),
      tabletBody: WebLayout(
        imageWidget: Image.asset(
          "../../assets/images/signup.png",
          width: 200,
        ),
        dataWidget: RegisterForm(),
      ),
    );
  }
}