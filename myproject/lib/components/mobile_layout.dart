import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final Image imageWidget;
  final Widget dataWidget;

  const MyWidget({
    Key? key,
    required this.imageWidget,
    required this.dataWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: [
          imageWidget,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: dataWidget,
          ),
        ],
      ),
    );
  }
}
