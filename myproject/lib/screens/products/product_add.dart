import 'package:flutter/material.dart';
import 'package:myproject/models/product_model.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKeyAddProduct = GlobalKey<FormState>();

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
      body: const Center(child: Text("Add New Product!!! ")),
    );
  }
}
