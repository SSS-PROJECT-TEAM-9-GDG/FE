import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/url/model/Url.dart';
import 'package:sssproject_frontend/url/repository/urlSearchService.dart';
import 'package:sssproject_frontend/util/view/errorScreen.dart';
import 'package:sssproject_frontend/url/view/urlResultScreen.dart';

class URLSearchScreen extends StatefulWidget {
  const URLSearchScreen({super.key});

  @override
  State<URLSearchScreen> createState() => _URLSearchScreenState();
  }

class _URLSearchScreenState extends State<URLSearchScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _errorText;
  bool isValid = false;
  UrlSearchService urlSearchService = UrlSearchService();
  Future<Url>? urlData;

  void validateURL() {
    setState(() {
      String input = _urlController.text.trim();
      if (input.isEmpty) {
        _errorText = "URL을 입력해주세요.";
        isValid = false;
      } else {
        _errorText = null;
        isValid = true;
      }
    });
  }

  Future<Url> getUrlResult() {
    if (_urlController.text.trim() == "badurltest.com"){
      return urlData = Future.value(Url(url: "badurltest.com", maliciousCount: 5, malicious: true));
    }
    return urlData = urlSearchService.getUrlData(_urlController.text);
  }

  @override
  void initState() {
    super.initState();
    urlData = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryBlue.withOpacity(0.5),
        appBar: AppBar(
          title: const Text("URL 검색", style: appBarStyle,),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "URL을 입력해주세요.",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: errorRed),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: errorRed),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    errorText: _errorText,
                    filled: true,
                    fillColor: backgroundWhite,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isValid = false;
                      _errorText = null;
                    });
                  },
                  onSubmitted: (value) => validateURL(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateURL();
                  if (isValid) {
                    setState(() {
                      getUrlResult();
                    });
                  FocusScope.of(context).unfocus(); 
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),),
                child: const Text("검색", style: buttonStyle),
              ),
              const SizedBox(height: 30),
      
              // FutureBuilder로 비동기 데이터를 처리
              if (urlData!=null)
                FutureBuilder<Url>(
                  future: urlData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return errorWidget(context);
                    } else if (snapshot.hasData) {
                      return urlResultWidget(snapshot.data!, context);
                    } else {
                      return const Text('');
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}