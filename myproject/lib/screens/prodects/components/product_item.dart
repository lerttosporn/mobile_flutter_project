import 'package:flutter/material.dart';
import 'package:myproject/components/image_not_found.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/utils/constant.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.product,
    this.onTap,
    this.isGrid,
    super.key,
  });

  final ProductModel product;
  final VoidCallback? onTap;
  final bool? isGrid;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onTap,
      child: LayoutBuilder(
        builder: (context, constraint) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [_buildImage(constraint.maxHeight), _buildInfo()],
          ),
        ),
      ),
    );
  }

  // _buildImage Widget
  Stack _buildImage(double maxHeight) {
    // Check list or grid view
    // Case of list view
    var height = maxHeight * 0.70;

    // Case of grid view
    if (isGrid != null && isGrid == true) {
      height = maxHeight * 0.48;
    }

    final image = product.image;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: image != null && image.isNotEmpty
              ? _image(image)
              : const ImageNotFound(),
        ),
      ],
    );
  }

  // _image Widget
  Container _image(String image) {
    String imageUrl;
    if (image.contains('://')) {
      imageUrl = image;
    } else {
      imageUrl = '$baseURLImage$image';
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // _buildInfo Widget
  Expanded _buildInfo() => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name ?? '',
            style: (isGrid ?? false)
                ? const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal)
                : const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '฿${product.price}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${product.stock} ชิ้น',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
