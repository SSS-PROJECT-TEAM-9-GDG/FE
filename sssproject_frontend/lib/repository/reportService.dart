import 'package:dio/dio.dart';
import 'package:sssproject_frontend/model/Report.dart';

class ReportService {
  final dio = Dio();
  
  Future<List<Report>> getReportData() async{
    Response response;
    try{
      String url = 'http://43.200.169.250:8080/report/info/voicephishing';
      response = await dio.get(url);
      if(response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((report) => Report.fromJson(report)).toList(); 
      } else {
        throw Exception('Fail to load data');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load report data: ${e.response?.data['message'] ?? e.message}');
    }
  }
}