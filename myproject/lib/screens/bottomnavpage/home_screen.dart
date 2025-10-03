import 'package:flutter/material.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/screens/products/components/product_item.dart';
import 'package:myproject/services/rest_api.dart';
import 'package:myproject/utils/app_router.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGridView = true;

  void _toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _toggleView(),
          //onPressed:toggleView,
          icon: Icon(
            isGridView ? Icons.list_outlined : Icons.grid_view_outlined,
          ),
        ),
        title: Text("สินค้า"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12), // ขยับเข้าด้านในนิดหน่อย
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRouter.productAdd,
                );
                if (result == true) {
                  setState(
                    () {},
                  ); // สั่งให้ build ใหม่ แล้ว FutureBuilder จะ reload                Navigator.pushNamed(context,AppRouter.productAdd);
                }
              },
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: FutureBuilder(
          future: CallAPI().getProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            // กรณีที่มี error
            if (snapshot.hasError) {
              return const Center(
                child: Text('มีข้อผิดพลาด โปรดลองใหม่อีกครั้ง'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // กรณีที่โหลดข้อมูลสำเร็จ
              List<ProductModel> products = snapshot.data;
              return isGridView ? gridView(products) : listView(products);
            } else {
              // กรณีที่กำลังโหลดข้อมูล
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget gridView(List<ProductModel> productList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisExtent: 200,
        mainAxisSpacing: 0,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductItem(
          product: productList[index],
          isGrid: true,
          onTap: () {
            Navigator.pushNamed(
                context,
                AppRouter.productDetail,
                arguments: productList[index].toJson(),
                );
              },
        ),
      ),
    );
  }

  Widget listView(List<ProductModel> productList) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: SizedBox(
          height: 350,
          child: ProductItem(
            product: productList[index],
            isGrid: false,
            onTap: () => {
              Navigator.pushNamed(
                context,
                AppRouter.productDetail,
                arguments: productList[index].toJson(),
              )
            },
          ),
        ),
      ),
    );
  }
}
