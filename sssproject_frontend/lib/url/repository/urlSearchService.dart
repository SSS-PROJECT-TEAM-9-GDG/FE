import 'package:dio/dio.dart';
import 'package:sssproject_frontend/const/dio.dart';
import 'package:sssproject_frontend/url/model/Url.dart';

class UrlSearchService {
final dio = Dio();

  UrlSearchService() {
    dio.options.validateStatus = (status) {
      return status != null && status < 500; // 500 이상의 오류는 예외로 처리하지 않음
    };
  }
  
  Future<Url> getUrlData(String url) async{
    Response response;
    try{
      String serverUrl = '$BASE_URL/api/urlcheck/scan';
      response = await dio.post(
        serverUrl,
        data: {'url' : url,}
      );

      if(response.statusCode == 200) {
        print("url 전송 선공!");
        print('Response Data: ${response.data}');
        return Url.fromJson(response.data);
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