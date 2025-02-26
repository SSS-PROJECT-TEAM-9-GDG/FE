// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sssproject_frontend/const/dio.dart';
// import 'package:sssproject_frontend/noise/model/Noise.dart';

// class NoiseService{
//   final dio = Dio();

//   Future<Noise> getNoiseData(String level, XFile image) async{
//     Response response;
//     try{
//       String serverUrl = '$BASE_URL/api/noise/apply?level=$level';
//       response = await dio.post(
//         serverUrl,
//         data: {'file' : image}
//       );

//       if(response.statusCode == 200) {
//         return Noise.fromJson(response.data);
//       } else {
//         throw Exception('Fail to load data');
//       }
//     } on DioException catch (e) {
//       String errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
//       if (e.response != null) {
//         if (e.response!.statusCode == 500) {
//           errorMessage = '서버에서 처리할 수 없는 오류가 발생했습니다.';
//         }
//         errorMessage = e.response?.data['message'] ?? errorMessage;
//       } else {
//         // 네트워크 오류나 기타 오류 처리
//         errorMessage = e.message ?? errorMessage;
//       }
//       throw Exception('Failed to load report data: ${e.response?.data['message'] ?? e.message}');
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sssproject_frontend/const/dio.dart';

class NoiseService {
  final Dio _dio = Dio();

  Future<void> getNoiseData(String? level, XFile? image) async {
    if (level == null || image == null) {
      print('⚠️ 요청할 데이터가 없습니다: level=$level, image=$image');
      return;
    }

    final String url = '$BASE_URL/api/noise/apply?level=$level';

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
      });

      print('📤 요청 보내는 중: $url');

      final Response response = await _dio.post(
        url,
        data: formData,
      );

      print('✅ 응답 코드: ${response.statusCode}');
      print('📩 응답 본문: ${response.data}');

      if (response.statusCode == 200) {
        print('🎉 서버와 정상 통신 완료!');
      } else {
        print('❌ 서버 오류 발생: ${response.statusCode}');
      }
    } catch (e) {
      print('🚨 요청 중 오류 발생: $e');
    }
  }
}