import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myproject/components/image_not_found.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/bottomnavpage/home_screen.dart';
import 'package:myproject/screens/products/components/product_form.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/constant.dart';
import 'package:myproject/utils/utility.dart';

class ProductUpdate extends StatefulWidget {
  const ProductUpdate({super.key});

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  final _formKeyUpdateProduct = GlobalKey<FormState>();
  final _product = ProductModel(
    id: 0,
    name: "",
    description: "",
    barcode: "",
    stock: 0,
    price: 0,
    categoryId: 1,
    userId: 1,
    statusId: 1,
    image: "",
  );
  // ไฟล์รูปภาพ
  File? _imageFile;
  // ✅ Callback สำหรับเซ็ตรูปภาพ
  String? _webImageUrl;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      return const Scaffold(body: Center(child: Text("ไม่พบข้อมูลสินค้า")));
    }
    final product = ProductModel.fromJson(
      args["products"],
    ); //ส่งมาแบบโดนห่ออีกชั้นนึง  arguments: {'products':  product.toJson()},
    // Utility.logger.i("UPDATE product args: ${args}");
    // Utility.logger.i("UPDATE product: ${product.toJson()}");

    // set ค่าเริ่มต้นให้กับ Model
    _product.id = product.id;
    _product.name = product.name;
    _product.description = product.description;
    _product.barcode = product.barcode;
    _product.stock = product.stock;
    _product.price = product.price;
    _product.categoryId = product.categoryId;
    _product.userId = product.userId;
    _product.statusId = product.statusId;
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // // set ค่าเริ่มต้นให้กับ Model
    // _product.id = arguments['products']['id'];
    //     _product.name = arguments['products']['name'];
    //     _product.description = arguments['products']['description'];
    //     _product.barcode = arguments['products']['barcode'];
    //     _product.stock = arguments['products']['stock'];
    //     _product.price = arguments['products']['price'];
    //     _product.categoryId = arguments['products']['category_id'];
    //     _product.userId = arguments['products']['user_id'];
    //     _product.statusId = arguments['products']['status_id'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKeyUpdateProduct.currentState!.validate()) {
                _formKeyUpdateProduct.currentState!.save();
                final response = await CallAPI().updateProduct(
                  _product,
                  imageFile: _imageFile,
                  webImageUrl: _webImageUrl,
                );
                Utility.logger.i("UPDATE response :${response}");
                if (response["status"] == "ok") {
                  // if (true) {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  refreshKey.currentState!.show();
                } else {
                  Utility.logger.e(" api error ");
                }
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            product.image != null && product.image!.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
                            : _webImageUrl != null
                            ? NetworkImage(_webImageUrl!)
                            : NetworkImage(baseURLImage + "/" + product.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ImageNotFound(),
                  ),
            ProductForm(
              _product,
              formKey: _formKeyUpdateProduct,
              callBackSetImage: _callBackSetImage,
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
