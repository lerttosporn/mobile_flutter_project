import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject/components/custom_textfield.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/products/components/product_image.dart';

class ProductForm extends StatefulWidget {
  final ProductModel product;
  final Function(File? file, [String? webImageUrl]) callBackSetImage;
  final GlobalKey<FormState> formKey;

  const ProductForm(
    this.product, {
    required this.callBackSetImage,
    required this.formKey,
    super.key,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
        child: Column(
          children: [
            customTextFieldProduct(
              initialValue: widget.product.name.toString(),
              hintText: 'ชื่อสินค้า',
              prefixIcon: const Icon(Icons.shopping_bag_outlined),
              obscureText: false,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'กรุณากรอก ชื่อสินค้า'
                  : null,

              onSaved: (value) => widget.product.name = value!,
            ),
            const SizedBox(height: 10),
            customTextFieldProduct(
              initialValue: widget.product.description.toString(),
              hintText: 'รายละเดียด',
              textInputType: TextInputType.multiline,
              maxLines: 5,
              prefixIcon: const Icon(Icons.description_outlined),
              obscureText: false,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'กรุณากรอก รายละเดียดสินค้า'
                  : null,

              onSaved: (value) => widget.product.description = value!,
            ),
            const SizedBox(height: 10),
            customTextFieldProduct(
              initialValue: widget.product.barcode.toString(),
              hintText: 'บาร์โค้ดสินค้า',
              textInputType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              prefixIcon: const Icon(Icons.qr_code_scanner_outlined),
              obscureText: false,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'กรุณากรอก บาร์โค้ดสินค้า'
                  : null,

              onSaved: (value) => widget.product.barcode = value!,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: customTextFieldProduct(
                    initialValue: widget.product.price.toString(),
                    hintText: 'ราคาสินค้า',
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    prefixIcon: const Icon(Icons.attach_money_outlined),
                    obscureText: false,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'กรุณากรอก ราคาสินค้า'
                        : null,

                    onSaved: (value) =>
                        widget.product.price = int.parse(value!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: customTextFieldProduct(
                    initialValue: widget.product.stock.toString(),
                    hintText: 'จำนวนสินค้า',
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    prefixIcon: const Icon(Icons.shopping_cart_outlined),
                    obscureText: false,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'กรุณากรอก จำนวนสินค้า'
                        : null,

                    onSaved: (value) =>
                        widget.product.stock = int.parse(value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: customTextFieldProduct(
                    initialValue: widget.product.categoryId.toString(),
                    obscureText: false,
                    hintText: 'หมวดหมู่',
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.category_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกหมวดหมู่สินค้า';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        widget.product.categoryId = int.parse(value!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: customTextFieldProduct(
                    initialValue: widget.product.userId.toString(),
                    hintText: 'ผู้ใช้',
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.person_outline),
                    obscureText: false,
                    validator: (value) => value == null || value.isEmpty
                        ? 'กรุณากรอกผู้ใช้งาน'
                        : null,
                    onSaved: (value) =>
                        widget.product.userId = int.parse(value!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: customTextFieldProduct(
                    initialValue: widget.product.statusId.toString(),
                    obscureText: false,
                    hintText: 'สถานะ',
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.check_circle_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอกสถานะสินค้า';
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        widget.product.statusId = int.parse(value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ProductImage(
              widget.callBackSetImage,
              imageUrl: widget.product.image,
            ),
          ],
        ),
      ),
    );
  }
}
