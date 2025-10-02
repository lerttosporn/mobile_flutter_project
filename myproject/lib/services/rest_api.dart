import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:myproject/models/product_model.dart';
import 'package:myproject/services/http_config.dart';
import 'package:myproject/utils/constant.dart';
import 'package:myproject/utils/utility.dart';
import 'package:path/path.dart';

class CallAPI {
  Future<Map<String, dynamic>> registerApi(data) async {
    Utility.logger.d(data);
    try {
      final response = await http.post(
        Uri.parse('${baseURLAPI}/auth/register'),
        headers: await HttpConfig.headers,
        body: jsonEncode(data),
      );
      Utility.logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      Utility.logger.e(e.toString());
      return {'message': 'Error'};
    }
  }

  Future<Map<String, dynamic>> loginApi(data) async {
    Utility.logger.d(data);
    try {
      final response = await http.post(
        Uri.parse('${baseURLAPI}/auth/login'),
        headers: await HttpConfig.headers,
        body: jsonEncode(data),
      );
      Utility.logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      Utility.logger.e(e.toString());
      return {'message': 'Error'};
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final headers = await HttpConfig.headers;
      // final token = (await HttpConfig.headers)['Authorization'];
      // final token = headers["Authorization"];
      final response = await http.get(
        Uri.parse('${baseURLAPI}/products'),
        headers: headers,
        // headers:
        // {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer ${token}', // <-- ใส่ token ตรงนี้
        // },
      );
      // Utility.logger.d(response.body);
      // return jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<ProductModel> product_list = productModelFromJson(
          response.body,
        );
        return product_list;
      }
      throw Exception('Failed to load products: ${response.statusCode}');
    } catch (e) {
      Utility.logger.e('Error: $e');
      return []; // ← ส่งกลับ list ว่างเมื่อ error
    }
  }

  Future<String> addProductAPI(ProductModel product, {File? imageFile}) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseURLAPI/product"),
    );
    final headers = await HttpConfig.headers;
    request.headers.addAll(headers);
    request.fields['name'] = product.name ?? "";
    request.fields['description'] = product.description ?? "";
    request.fields['barcode'] = product.barcode ?? "";
    request.fields['stock'] = product.stock.toString();
    request.fields['price'] = product.price.toString();
    request.fields['catetagory_id'] = product.categoryId.toString();
    request.fields['user_id'] = product.userId.toString();
    request.fields['status_id'] = product.statusId.toString();

    if (imageFile != null) {
      final mimeType = MediaType('image', 'jpeg'); // หรือ image/png ถ้าจำเป็น
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          contentType: mimeType,
          filename: basename(imageFile.path),
        ),
      );
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      Utility.logger.d(jsonDecode(response.body)); // debug log
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to create product: ${response.statusCode} - ${response.body}",
      );
    }
  }

  //for dio-------------------------------------------------------------------------------------------
  // Future<String> addProductApi(ProductModel product, {File? imageFile}) async {
  //   final formData = FormData.fromMap({
  //     'name': product.name,
  //     'description': product.description,
  //     'barcode': product.barcode,
  //     'stock': product.stock,
  //     'price': product.price,
  //     'catetagory_id': product.categoryId,
  //     'user_id': product.userId,
  //     'status_id': product.statusId,
  //     if (imageFile != null)
  //       'photo': await MultipartFile.fromFile(
  //         imageFile.path,
  //         contentType: MediaType('image', 'jpg'),
  //       ),
  //   });

  //   final headers = await HttpConfig.headers;

  //   final dio = Dio();
  //   final response = await dio.post(
  //     '${baseURLAPI}/auth/',
  //     data: formData,
  //     options: Options(headers: headers),
  //   );

  //   if (response.statusCode == 200) {
  //     Utility.logger.d(response.data);
  //     return jsonDecode(
  //       response.data,
  //     ); // หรือแปลงตามประเภทข้อมูลที่ backend ส่งมา
  //   }

  //   throw Exception("Failed to create product");
  // }
  // final Dio _dio = DioConfig.dio;
  //for dio-------------------------------------------------------------------------------------------

  // registerAPI(data) async {
  //   //check connection
  //   // if (await Utility.logger.d.checkNetwork() == 'No Network Connection') {
  //   //   return jsonEncode({'message': 'No Network Connection'});
  //   // } else {
  //         logger.d(data);
  //   try {
  //     final response = await _dio.post(
  //       '/auth/register',
  //       data: data,
  //     );
  //     logger.d(response.data);
  //     return jsonEncode(response.data);
  //   } catch (e) {
  //     logger.e(e);
  //     return jsonEncode({'message': 'Error'});
  //   }
  //   // }
  // }
}
