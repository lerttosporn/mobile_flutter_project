import 'package:flutter/material.dart';
import 'package:myproject/models/product_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    // 👇 รับ arguments ที่ส่งมา
    final args = ModalRoute.of(context)?.settings.arguments;
    // 👇 แปลงกลับเป็น ProductModel
    final product = ProductModel.fromJson(args as Map<String, dynamic>);

    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? 'รายละเอียดสินค้า')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ชื่อสินค้า: ${product.name}"),
            Text("รายละเอียด: ${product.description}"),
            Text("บาร์โค้ด: ${product.barcode}"),
            Text("ราคา: ${product.price}"),
            Text("สถานะ: ${product.statusId}"),
            Text("จำนวน: ${product.stock}"),
            Text("วันที่สร้าง: ${product.createdAt}"),
            Text("แก้ไขล่าสุด: ${product.updatedAt}"),
            // เพิ่มอื่น ๆ ตามต้องการ
          ],
        ),
      ),
    );
  }
}
