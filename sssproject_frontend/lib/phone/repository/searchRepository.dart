import 'package:dio/dio.dart';
import 'package:sssproject_frontend/const/crime.dart';
import 'package:sssproject_frontend/const/dio.dart';
import 'package:sssproject_frontend/report/model/Report.dart';
import 'package:sssproject_frontend/phone/dio/PhoneNumber.dart';

class SearchService{
  final dio = Dio();

    Future<PhoneNumber> getPhoneNumberSearchService(String phoneNumber) async{
    Response response;
    try{
      String serverUrl = '$BASE_URL/api/spam/check';
      response = await dio.post(
        serverUrl,
        data: {"number" : phoneNumber,}
      );

      if(response.statusCode == 200) {
        print("phoneNumber 전송 선공!");
        print('Response Data: ${response.data}');
        return PhoneNumber.fromJson(response.data);
      } else {
        throw Exception('Fail to load data');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load report data: ${e.response?.data['message'] ?? e.message}');
    }
  }
}