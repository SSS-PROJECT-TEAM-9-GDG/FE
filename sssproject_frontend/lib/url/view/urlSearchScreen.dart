import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/url/model/Url.dart';
import 'package:sssproject_frontend/url/repository/urlSearchService.dart';
import 'package:sssproject_frontend/url/view/safeUrlWidget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue.withOpacity(0.5),
      appBar: AppBar(
        title: const Text("URL 검색"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: "URL을 입력해주세요.",
                border: const OutlineInputBorder(),
                errorText: _errorText,
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  isValid = false;
                  _errorText = null;
                });
              },
              onSubmitted: (value) => validateURL(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                validateURL();
                if (isValid) { // ✅ 유효성 검사 통과한 경우에만 실행
                  setState(() {
                    urlData = urlSearchService.getUrlData(_urlController.text);
                  });
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: secondaryBlue),
              child: const Text("검색", style: TextStyle(color: textBlack)),
            ),
            const SizedBox(height: 20),
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
                    return safeUrlWidget(snapshot.data!);
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