import 'package:flutter/material.dart';

Widget customtextField({
  required TextEditingController controller,
  required String hintText,
  required Icon prefixIcon,
  required bool isObscureText,
   TextInputType keyboard=TextInputType.text,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboard,
    obscureText: isObscureText,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      fillColor: Colors.grey[300],
    ),
  );
}
