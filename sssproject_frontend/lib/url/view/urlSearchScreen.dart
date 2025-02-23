import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/url/model/Url.dart';
import 'package:sssproject_frontend/url/repository/urlSearchService.dart';
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

  // URL 유효성 검사 함수
  bool isValidURL(String url) {
    final RegExp urlPattern = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  void validateURL() {
    setState(() {
      String input = _urlController.text.trim();
      if (input.isEmpty) {
        _errorText = "URL을 입력해주세요.";
        isValid = false;
      } else if (!isValidURL(input)) {
        _errorText = "URL을 정확하게 입력해주세요.";
        isValid = false;
      } else {
        _errorText = null;
        isValid = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    urlData = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: borderGrey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: borderGrey),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: errorRed, width: 1.7),
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
                    urlData = urlSearchService.getUrlData(_urlController.text);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),),
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
                    return Text('Error: ${snapshot.error}');
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
    );
  }
}