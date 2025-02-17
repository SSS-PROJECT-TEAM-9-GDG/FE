import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/model/Report.dart';
import 'package:sssproject_frontend/repository/reportService.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailScreen extends StatefulWidget {
  final int index;

  const ReportDetailScreen({super.key, required this.index});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final dio = Dio();
  List<Report> reportData = [];
  ReportService reportService  = ReportService();

  @override
  void initState() {
    super.initState();
    _loadReport();
  } 

  Future<void> _loadReport() async {
    try{
      final data = await reportService.getReportData();
      setState(() {
        reportData = data;
      });
    } catch(e) {
      print('Error loading Board infomation: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('범죄 유형 ${widget.index}',),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundSquare.png'),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
                SizedBox(
                  height: 170,
                  child: Row(
                    children: [
                    Image.asset('assets/images/goormCharactor.png', width: 141, height: 148,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/sheildCharactor.png', width: 48, height: 48,)
                      )
                    ]
                  ),
                ),
                const Expanded(
                  child: Card(
                    elevation: 5,
                    color: backgroundWhite,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('내용')
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryBlue,
                ),
                onPressed:() async{launchUrl(Uri.parse('https://github.com/SSS-PROJECT-TEAM-9-GDG/FE'));}, 
                child: const Text('신고 버튼 자리', style: TextStyle(color: textBlack, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}