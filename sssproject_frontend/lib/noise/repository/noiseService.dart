import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sssproject_frontend/const/dio.dart';

class NoiseService {
  final Dio _dio = Dio();

  Future<void> getNoiseData(String? level, XFile? image) async {
    if (level == null || image == null) {
      print('⚠️ 요청할 데이터가 없습니다: level=$level, image=$image');
      return;
    }

    const String url = '$BASE_URL/api/noise/apply';

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
      });

      print('📤 요청 보내는 중: $url');

      final Response response = await _dio.post(
        url,
        queryParameters: {"level": level},
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