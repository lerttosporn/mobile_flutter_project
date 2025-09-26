import 'package:flutter/material.dart';
import 'package:myproject/components/custom_textfield.dart';
import 'package:myproject/components/rounded_button.dart';
import 'package:myproject/components/social_media_option.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/utility.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  // สร้าง GlobalKey สำหรับ Form นี้
  final _formKeyLogin = GlobalKey<FormState>();

  // สร้าง TextEditingController
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "เข้าสู่ระบบ",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKeyLogin,
            child: Column(
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // Open Forgot Password screen here
                      },
                      child: const Text("ลืมรหัสผ่าน?"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                RoundedButton(
                  label: "เข้าสู่ระบบ",
                  onPressed: () async {
                    if (_formKeyLogin.currentState!.validate()) {
                      _formKeyLogin.currentState!.save();

                      var response = await CallAPI().loginApi({
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      });
                      var body = response;
                      Utility.logger.i(body);
                      if (body["status"] == "ok") {
                        Utility.showAlertDialog(
                          context,
                          body["status"],
                          '${body["message"]}',
                        );
                        //สามารถเก็บขเป็นList หรือ Map ได้
                       await Utility.setSharedPreferance("loginStatus", true);
                       await Utility.setSharedPreferance("token", body["token"]);
                       await Utility.setSharedPreferance("user", body["user"]);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouter.dashboard,
                          (route) => false,//ลบหน้าก่อนหน้าออกหมด
                        );
                       await Utility.setSharedPreferance("loginStatus", true);
                      } else {
                        Utility.showAlertDialog(
                          context,
                          body["status"],
                          '${body["message"]}',
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SocialMediaOption(),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ยังไม่มีบัญชีกับเรา? "),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.register);
                },
                child: const Text(
                  "สมัครฟรี",
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
    );
  }
}
