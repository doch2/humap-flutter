import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class ApiProvider {
  final apiUrl = "https://humap-api.dohui.me";

  Dio _dio = Get.find<Dio>();

  getSummaryKeyword(String data) async {
    try {
      Response response = await _dio.post(
        "$apiUrl/",
        options: Options(contentType: "application/json"),
        data: {
          "data": data,
        },
      );

      return {
        "success": true,
        "content": response.data['result']
      };
    } on DioError catch (e) {
      return {
        "success": false,
        "content": e.response?.data["message"]
      };
    }
  }
}