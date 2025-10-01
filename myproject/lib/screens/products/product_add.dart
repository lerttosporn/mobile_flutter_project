import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
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
