import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sssproject_frontend/const/dio.dart';
import 'package:sssproject_frontend/phone/dio/PhoneNumber.dart';

class PhoneSearchService{
  final dio = Dio();

    Future<PhoneNumber> getPhoneNumberData(String phoneNumber) async{
    Response response;
    try{
      String serverUrl = '$BASE_URL/api/spam/check';
      response = await dio.post(
        serverUrl,
        data: {'number' : phoneNumber,}
      );

      if(response.statusCode == 200) {
        final jsonData = jsonDecode(response.data);
        return PhoneNumber.fromJson(jsonData['data']);
      } else {
        throw Exception('Fail to load data');
      }
    } on DioException catch (e) {
      String errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
      if (e.response != null) {
        if (e.response!.statusCode == 500) {
          errorMessage = '서버에서 처리할 수 없는 오류가 발생했습니다.';
        }
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else {
        // 네트워크 오류나 기타 오류 처리
        errorMessage = e.message ?? errorMessage;
      }
      throw Exception('Failed to load report data: ${e.response?.data['message'] ?? e.message}');
    }
  }
}