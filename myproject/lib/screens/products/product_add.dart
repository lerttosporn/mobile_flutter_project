import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/bottomnavpage/home_screen.dart';
import 'package:myproject/screens/products/components/product_form.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/utility.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  // สร้าง GlobalKey สำหรับฟอร์ม
  final _formKeyAddProduct = GlobalKey<FormState>();

  // สร้างตัวแปรสำหรับเก็บข้อมูล Product
  final _product = ProductModel(
    name: "",
    description: "",
    barcode: "",
    stock: 0,
    price: 0,
    categoryId: 1,
    userId: 1,
    statusId: 1,
  );

  // ไฟล์รูปภาพ
  File? _imageFile;
  // ✅ Callback สำหรับเซ็ตรูปภาพ
  String? _webImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product!!! "),
        actions: [
          IconButton(
            onPressed: () async {
              if (_imageFile == null && _webImageUrl == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("ยังไม่ได้เลือกรูปภาพ"),
                    content: const Text("กรุณาเลือกรูปภาพก่อนบันทึกข้อมูล"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("ตกลง"),
                      ),
                    ],
                  ),
                );
                return;
              }
              if (_formKeyAddProduct.currentState!.validate()) {
                _formKeyAddProduct.currentState!.save();
                Utility.logger.d("***Product ADD*** :${_product.toJson()}");
                // Utility.logger.d(
                //   "***ProductADD*** :_webImagePath = $_webImageUrl",
                // );
                // Utility.logger.d("***Product ADD*** :_imageFile = $_imageFile");
                final response = await CallAPI().addProductAPI(
                  _product,
                  imageFile: _imageFile,
                  webImageUrl: _webImageUrl,
                );
                // Utility.logger.d("Product Created: ${response["product"]}");
                if (response['status'] == 'ok') {
                  Navigator.pop(context, true);
                  refreshKey.currentState!.show();
                } else {
                  Utility.logger.e(" api error ");
                }
              }
            },
            icon: const Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductForm(
              _product,
              callBackSetImage: _callBackSetImage,
              formKey: _formKeyAddProduct,
            ),
          ],
        ),
      ),
    );
  }

  void _callBackSetImage(
    File? imageFile, [
    //ใช้กับ Web
    String? webImageUrl,
  ]) {
    setState(() {
      _imageFile = imageFile;
      _webImageUrl = webImageUrl;
    });
  }
}
