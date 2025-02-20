import 'package:dio/dio.dart';
import 'package:sssproject_frontend/const/crime.dart';
import 'package:sssproject_frontend/const/dio.dart';
import 'package:sssproject_frontend/model/Report.dart';

class ReportService{
  final dio = Dio();
  
  Future<Report> getReportData(int index) async{
    Response response;
    try{
      String url = '$BASE_URL/report/info/${crime[index]}';
      response = await dio.get(url);

      if(response.statusCode == 200) {
        return Report.fromJson(response.data);
      } else {
        throw Exception('Fail to load data');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load report data: ${e.response?.data['message'] ?? e.message}');
    }
  }
}