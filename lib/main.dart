import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const URLSearchScreen(),
    );
  }
}

class URLSearchScreen extends StatefulWidget {
  const URLSearchScreen({super.key});

  @override
  State<URLSearchScreen> createState() => _URLSearchScreenState();
}

class _URLSearchScreenState extends State<URLSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool isValid = false;

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
      String input = _controller.text.trim();
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
      backgroundColor: Colors.lightBlue[100],
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
              controller: _controller,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: "URL을 입력해주세요.",
                border: const OutlineInputBorder(),
                errorText: _errorText,
                filled: true,
                fillColor: Colors.white,
              ),
              // 재입력시 기존 검색 결과 초기화 (URL 재검색)
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
              onPressed: validateURL,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text("검색", style: TextStyle(color: Colors.white)),
            ),
            if (isValid) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/character.png',
                      width: 210,
                      height: 180,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const Text(
                      "안심할 수 있는 URL이에요!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "최근 3개월 내에\n3건 이상 접수된 민원이 없어요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}











 
