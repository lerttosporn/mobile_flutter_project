import 'package:flutter/material.dart';
import 'package:myproject/components/custom_textfield.dart';
import 'package:myproject/components/rounded_button.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/utility.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});
  final _formKeyRegister = GlobalKey<FormState>();
  final _firstNameControler = TextEditingController();
  final _lastNameControler = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "สมัครสมาชิก",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKeyRegister,
            child: Column(
              children: [
                customtextField(
                  controller: _firstNameControler,
                  hintText: "First Name",
                  prefixIcon: const Icon(Icons.person),
                  isObscureText: false,
                  keyboard: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกชื่อ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                customtextField(
                  controller: _lastNameControler,
                  hintText: "Last Name",
                  prefixIcon: const Icon(Icons.person),
                  isObscureText: false,
                  keyboard: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกนามสกุล";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                customtextField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  isObscureText: false,
                  keyboard: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกอีเมล";
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return "กรุณากรอกอีเมลให้ถูกต้อง";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                customtextField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  isObscureText: true,
                  keyboard: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่าน";
                    } else if (value.length < 6) {
                      return "รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                customtextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  isObscureText: true,
                  keyboard: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณายืนยันรหัสผ่าน";
                    } else if (value != _passwordController.text) {
                      return "รหัสผ่านไม่ตรงกัน";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                RoundedButton(
                  label: "ยืนยัน",
                  onPressed: () async {
                    if (_formKeyRegister.currentState!.validate()) {
                      _formKeyRegister.currentState!.save();
                      var response = await CallAPI().registerApi({
                        "firstname": _firstNameControler.text,
                        "lastname": _lastNameControler.text,
                        "email": _emailController.text,
                        "password": _passwordController.text,
                        
                      });
                      Utility.logger.i(response); 
                    }
                  },
                ),
                const SizedBox(height: 10),
                RoundedButton(
                  label: "testRegister",
                  onPressed: () async {
                    var response = await CallAPI().registerApi({
                      "firstname": "John",
                      "lastname": "Doe",
                      "email": "john@example.com",
                      "password": "123456",
                    });
                    var body = response;
                    Utility.logger.i(body);
                  },
                ),
                const SizedBox(height: 10),
                RoundedButton(
                  label: "test",
                  onPressed: () async {
                    var response = await CallAPI().getProducts();
                    var body = response;
                    Utility.logger.i(body);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("มีบัญชีผู้ใช้งานอยู่แล้ว? "),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
