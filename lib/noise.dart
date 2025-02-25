import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NoiseUploadPage extends StatefulWidget {
  @override
  _NoiseUploadPageState createState() => _NoiseUploadPageState();
}

class _NoiseUploadPageState extends State<NoiseUploadPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (mounted) { // ✅ mounted 체크 후 setState() 호출
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      print("이미지 선택 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("노이즈 추가"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.lightBlue[100], // 배경색
              child: Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 50, color: Colors.grey), // ✅ 아이콘 추가
                              SizedBox(height: 10),
                              Text("사진을 선택해주세요.", style: TextStyle(fontSize: 16)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: double.infinity, // ✅ 크기 조정
                              height: double.infinity,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
