import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: URLPhoneSearchScreen(),
    );
  }
}

class URLPhoneSearchScreen extends StatefulWidget {
  const URLPhoneSearchScreen({super.key});

  @override
  State<URLPhoneSearchScreen> createState() => _URLPhoneSearchScreenState();
}

class _URLPhoneSearchScreenState extends State<URLPhoneSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool isURLMode = true;
  bool isValid = false;

  //URL 유효성 검사 함수
  bool isValidURL(String url) {
    final RegExp urlPattern = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  //전화번호 유효성 검사 (02 → 10자리, 010/011 → 11자리)
  bool isValidPhoneNumber(String phone) {
    final RegExp seoulPhonePattern = RegExp(r'^02\d{8}$'); // 02 + 8자리
    final RegExp mobilePhonePattern = RegExp(r'^(010|011)\d{8}$'); // 010 or 011 + 8자리

    return seoulPhonePattern.hasMatch(phone) || mobilePhonePattern.hasMatch(phone);
  }

  //입력 필드 초기화 함수
  void resetState() {
    setState(() {
      _controller.clear();
      _errorText = null;
      isValid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("URL/번호 검색"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기 기능 추가
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40), //버튼 위쪽 여백
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isURLMode = true;
                        resetState();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isURLMode ? Colors.blue : Colors.grey[300],
                    ),
                    child: const Text("URL", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 31), //버튼 사이 여백
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isURLMode = false;
                        resetState();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isURLMode ? Colors.blue : Colors.grey[300],
                    ),
                    child: const Text("전화번호", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: isURLMode ? TextInputType.url : TextInputType.phone,
              decoration: InputDecoration(
                labelText: isURLMode ? "URL을 입력해주세요." : "전화번호를 입력해주세요.",
                border: const OutlineInputBorder(),
                errorText: _errorText,
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _errorText = null;
                    isValid = false;
                  } else if (isURLMode && !isValidURL(value)) {
                    _errorText = "URL을 정확하게 입력해주세요.";
                    isValid = false;
                  } else if (!isURLMode && !isValidPhoneNumber(value)) {
                    _errorText = "전화번호를 정확하게 입력해주세요.";
                    isValid = false;
                  } else {
                    _errorText = null;
                    isValid = true;
                  }
                });
              },
            ),
            if (isValid) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    /// 이미지 추가 
                    Image.asset(
                      isURLMode ? "assets/images/character.png" : "assets/images/character.png",
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80, color: Colors.red),
                    ),
                    const SizedBox(height: 10),

                    // 텍스트
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_box, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(
                          isURLMode ? "안심할 수 있는 URL이에요!" : "안심할 수 있는 번호입니다!",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isURLMode
                          ? "~~~~한 URL이에요.\n안심하고 접속할 수 있어요."
                          : "최근 3개월 내에\n3건 이상 접수된 민원이 없어요.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "권한설정"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "노이즈 추가"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "신고"),
        ],
      ),
    );
  }
}








 
