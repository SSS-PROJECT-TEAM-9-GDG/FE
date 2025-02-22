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
      home: PhoneSearchScreen(),
    );
  }
}

class PhoneSearchScreen extends StatefulWidget {
  const PhoneSearchScreen({super.key});

  @override
  State<PhoneSearchScreen> createState() => _PhoneSearchScreenState();
}

class _PhoneSearchScreenState extends State<PhoneSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool isValid = false;

  // 전화번호 유효성 검사 (02 + 8자리 = 10자리, 010/011 + 8자리 = 11자리)
  bool isValidPhoneNumber(String phone) {
    final RegExp seoulPhonePattern = RegExp(r'^02\d{8}$'); // 02 + 8자리
    final RegExp mobilePhonePattern = RegExp(r'^(010|011)\d{8}$'); // 010/011 + 8자리
    return seoulPhonePattern.hasMatch(phone) || mobilePhonePattern.hasMatch(phone);
  }

  void validatePhone() {
    setState(() {
      final value = _controller.text.trim();
      if (value.isEmpty) {
        _errorText = "전화번호를 입력해주세요.";
        isValid = false;
      } else if (!isValidPhoneNumber(value)) {
        _errorText = "전화번호를 정확하게 입력해주세요.";
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
        title: const Text("번호 검색"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 전화번호 입력 필드
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "전화번호를 입력해주세요.",
                border: const OutlineInputBorder(),
                errorText: _errorText,
                filled: true,
                fillColor: Colors.white,
              ),
              // 엔터키 누르면 실행
              onSubmitted: (_) => validatePhone(),
            ),
            const SizedBox(height: 20),
            // 검색 버튼
            ElevatedButton(
              onPressed: validatePhone,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text("검색", style: TextStyle(color: Colors.white)),
            ),
            // 유효한 번호일 때만 결과 표시
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
                  children: [
                    Image.asset(
                      'assets/images/character.png',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 80, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check_box, color: Colors.green),
                        SizedBox(width: 5),
                        Text(
                          "안심할 수 있는 번호에요!",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "최근 3개월 내에\n3건 이상 접수된 민원이 없어요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
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

