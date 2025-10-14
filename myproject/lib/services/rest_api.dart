import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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

  Future<List<int>> _readBytesFromBlobUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to read bytes from blob URL');
    }
  }

  Future<Map<String, dynamic>> addProductAPI(
    ProductModel product, {
    File? imageFile,
    String? webImageUrl,
  }) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseURLAPI/products"), // ✅ อัปเดต endpoint
    );

    final headers = await HttpConfig.headers;
    request.headers.addAll(headers);

    // ✅ ใส่ค่า fields อย่างถูกต้อง
    request.fields['name'] = product.name ?? "";
    request.fields['description'] = product.description ?? "";
    request.fields['barcode'] = product.barcode ?? "";
    request.fields['stock'] = product.stock.toString();
    request.fields['price'] = product.price.toString();
    request.fields['category_id'] = product.categoryId
        .toString(); // ✅ แก้ชื่อ field
    request.fields['user_id'] = product.userId.toString();
    request.fields['status_id'] = product.statusId.toString();

    Utility.logger.i("Request Fields: ${request.fields}");

    // ✅ อัปโหลดไฟล์แบบ File
    if (imageFile != null) {
      final mimeType = MediaType('image', 'jpeg');
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          contentType: mimeType,
          filename: basename(imageFile.path),
        ),
      );
    }
    // ✅ สำหรับ Web - ใช้ bytes ไม่ใช่ base64 string
    else if (kIsWeb && webImageUrl != null) {
      final bytes = await _readBytesFromBlobUrl(webImageUrl);
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo',
          bytes,
          filename: 'web_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    // ✅ ส่ง request และรับ response
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final productData = responseData['product'];

      Utility.logger.d("***RestAPI*** responseData: $responseData");

      Utility.logger.d("***RestAPI*** productData: $productData");

      return responseData; // ✅ return เฉพาะ object ของ product
    } else {
      throw Exception(
        "Failed to create product: ${response.statusCode} - ${response.body}",
      );
    }
  }

  Future<String> deleteProductAPI(int id) async {
    final headers = await HttpConfig.headers;

    final uri = Uri.parse('$baseURLAPI/products/$id');
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      Utility.logger.d(response.body);
      return response.body;
    }
    throw Exception('Failed to delete product');
  }
Future updateProduct( ProductModel product, {
    File? imageFile,
    String? webImageUrl,
  }) async {
    final request = http.MultipartRequest(
      "PUT",
      Uri.parse("$baseURLAPI/products/${product.id}"), // ✅ อัปเดต endpoint
    );

    final headers = await HttpConfig.headers;
    request.headers.addAll(headers);

    // ✅ ใส่ค่า fields อย่างถูกต้อง
    request.fields['name'] = product.name ?? "";
    request.fields['description'] = product.description ?? "";
    request.fields['barcode'] = product.barcode ?? "";
    request.fields['stock'] = product.stock.toString();
    request.fields['price'] = product.price.toString();
    request.fields['category_id'] = product.categoryId
        .toString(); // ✅ แก้ชื่อ field
    request.fields['user_id'] = product.userId.toString();
    request.fields['status_id'] = product.statusId.toString();

    Utility.logger.i("Request Fields: id{${product.id}} ${request.fields}");

    // ✅ อัปโหลดไฟล์แบบ File
    if (imageFile != null) {
      final mimeType = MediaType('image', 'jpeg');
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          contentType: mimeType,
          filename: basename(imageFile.path),
        ),
      );
    }
    // ✅ สำหรับ Web - ใช้ bytes ไม่ใช่ base64 string
    else if (kIsWeb && webImageUrl != null) {
      final bytes = await _readBytesFromBlobUrl(webImageUrl);
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo',
          bytes,
          filename: 'web_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    // ✅ ส่ง request และรับ response
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final productData = responseData['product'];

      // Utility.logger.d("***RestAPI*** responseData: $responseData");

      // Utility.logger.d("***RestAPI*** productData: $productData");

      return responseData; // ✅ return เฉพาะ object ของ product
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
