import 'package:flutter/material.dart';
import 'package:myproject/components/image_not_found.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/bottomnavpage/home_screen.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/app_router.dart';
import 'package:myproject/utils/constant.dart';
import 'package:myproject/utils/utility.dart';
import 'dart:convert';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    // รับ arguments ที่ส่งมา
    final args = ModalRoute.of(context)?.settings.arguments;

    // ตรวจสอบว่า args เป็น Map หรือไม่
    if (args == null || args is! Map<String, dynamic>) {
      return const Scaffold(body: Center(child: Text("ไม่พบข้อมูลสินค้า")));
    }

    // แปลง args เป็น ProductModel
    final product = ProductModel.fromJson(args);
    Utility.logger.i("DetailPage args: $args");
    Utility.logger.i("DetailPage : ${product.toJson()}");
    Utility.logger.i(
      "DetailPage baseURLImage : ${baseURLImage + "/" + product.image!}",
    );

    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? 'ไม่มีชื่อสินค้า')),
      body: ListView(
        children: [
          product.image != null && product.image!.isNotEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(baseURLImage + "/" + product.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ImageNotFound(),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Text(
              'Barcode: ${product.barcode ?? "-"}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              product.description ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.productUpdate,
                      arguments: {'products': product},
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    // แสดง dialog ยืนยันการลบ
                    return showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('ยืนยันการลบสินค้า'),
                          content: Text(
                            'คุณต้องการลบสินค้า ${product.name ?? ""} ใช่หรือไม่?',
                          ),
                          actions: [
                            TextButton(
                              child: const Text('ยกเลิก'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('ยืนยัน'),
                              onPressed: () async {
                                // ลบสินค้า
                                final response = await CallAPI()
                                    .deleteProductAPI(product.id!);
                                Utility.logger.i("response detail: $response");

                                final result = jsonDecode(response);
                                if (result['status'] == 'ok') {
                                  // Refresh หน้าก่อนหน้า
                                  refreshKey.currentState?.show();
                                  // ปิด dialog
                                  Navigator.of(context).pop();
                                  // กลับไปหน้าก่อนหน้า
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
