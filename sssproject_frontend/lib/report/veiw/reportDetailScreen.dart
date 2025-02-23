import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/crime.dart';
import 'package:sssproject_frontend/const/images.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/report/model/Report.dart';
import 'package:sssproject_frontend/report/repository/reportService.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailScreen extends StatefulWidget {
  final int index;

  const ReportDetailScreen({super.key, required this.index});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final dio = Dio();
  Report? reportData;
  ReportService reportService  = ReportService();

  @override
  void initState() {
    super.initState();
    _loadReport();
  } 

  Future<void> _loadReport() async {
    try{
      final data = await reportService.getReportData(widget.index);
      setState(() {
        reportData = data;
      });
    } catch(e) {
      print('Error loading Board infomation: $e');
    }
  }

  List<Widget> getListData(List<String> listData) {
    return listData.map((data) => Text(data, style: bodyStyle, softWrap: true)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return 
    reportData == null 
      ? const Center(child: CircularProgressIndicator())
      :Scaffold(
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
            centerTitle: true,
            title: Text(crimeName[widget.index], style: appBarStyle,),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundSqure),
              fit: BoxFit.cover
            )
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ 
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Image.asset(goormCharactor, width: size.height*0.166, height: size.height*0.166,),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(sheildCharactor, width: size.height*0.057, height: size.height*0.057,)
                        )
                      ]
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Card(
                        elevation: 5,
                        color: backgroundWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reportData!.title, style: bigTitleStyle),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 3,
                                      color: const Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    const SizedBox(width: 6,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [...getListData(reportData!.description),],)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Text('[${crimeName[widget.index]}예방법]', style: titleStyle,),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 3,
                                      color: const Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    const SizedBox(width: 6,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [...getListData(reportData!.criteriaList),],)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              const Text("[신고방법]", style: titleStyle,),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 3,
                                      color: const Color.fromARGB(255, 191, 191, 191),
                                    ),
                                    const SizedBox(width: 6,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [...getListData(reportData!.contact),],)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryBlue,
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        ),
                        onPressed:() async{launchUrl(Uri.parse(reportData?.center ?? ''));}, 
                        child: const Text('신고 하러 가기', style: buttonStyle)),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}