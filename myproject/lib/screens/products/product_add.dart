import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/products/components/product_form.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product!!! "),
        actions: [
          IconButton(
            onPressed: () => {},
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

  void _callBackSetImage(File? imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }
}
