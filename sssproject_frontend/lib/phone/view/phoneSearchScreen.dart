import 'package:flutter/material.dart';
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/textstyle.dart';
import 'package:sssproject_frontend/phone/dio/PhoneNumber.dart';
import 'package:sssproject_frontend/phone/repository/phoneSearchService.dart';
import 'package:sssproject_frontend/phone/view/phoneResultScreen.dart';
import 'package:sssproject_frontend/util/view/errorScreen.dart';

class PhoneSearchScreen extends StatefulWidget {
  const PhoneSearchScreen({super.key});

  @override
  State<PhoneSearchScreen> createState() => _PhoneSearchScreenState();
  }

class _PhoneSearchScreenState extends State<PhoneSearchScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;
  bool isValid = false;
  PhoneSearchService phoneSearchService = PhoneSearchService();
  Future<PhoneNumber>? phoneData;

  void validateURL() {
    setState(() {
      String input = _phoneController.text.trim();
      if (input.isEmpty) {
        _errorText = "전화번호를 입력해주세요.";
        isValid = false;
      } else {
        _errorText = null;
        isValid = true;
      }
    });
  }

  Future<PhoneNumber> getPhoneResult() {
    if (_phoneController.text.trim() == "01077777777"){
      return phoneData = Future.value(PhoneNumber(spam: "허위광고", spamCount: 5, cyberCrime: '최근 3개월 내 3건 이상 접수된 민원이 없습니다.'));
    }
    return phoneData = phoneSearchService.getPhoneNumberData(_phoneController.text);
  }

  @override
  void initState() {
    super.initState();
    phoneData = null;
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
          title: const Text("전화번호 검색", style: appBarStyle,),
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
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "전화번호를 입력해주세요.",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: borderGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: errorRed, width: 1.7),
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
                      getPhoneResult();
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
              if (phoneData!=null)
                FutureBuilder<PhoneNumber>(
                  future: phoneData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return errorWidget(context);
                    } else if (snapshot.hasData) {
                      return phoneResultWidget(snapshot.data!, context);
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