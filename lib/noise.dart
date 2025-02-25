import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoiseEditorScreen(),
    );
  }
}

class NoiseEditorScreen extends StatefulWidget {
  const NoiseEditorScreen({super.key});

  @override
  _NoiseEditorScreenState createState() => _NoiseEditorScreenState();
}

class _NoiseEditorScreenState extends State<NoiseEditorScreen> {
  File? _image;
  double _noiseLevel = 0.0;
  Uint8List? _noisyImage;
  final ImagePicker _picker = ImagePicker();

  // 이미지 선택 및 권한 요청 (갤러리)
  Future<void> _pickImage() async {
    PermissionStatus status = Platform.isIOS
        ? await Permission.photos.request()
        : await Permission.storage.request();

    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _noisyImage = null;
          _noiseLevel = 0.0; // 초기화
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("저장소 접근 권한이 필요합니다.")),
      );
    }
  }

  // 노이즈 추가 
  void _applyNoise() {
    if (_image == null) return;

    final image = img.decodeImage(_image!.readAsBytesSync());
    if (image == null) return;

    final noiseAmount = (_noiseLevel * 255).toInt();
    final random = Random();

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        if (random.nextDouble() < _noiseLevel) {
          int noise = (random.nextInt(noiseAmount) - noiseAmount ~/ 2);
          var pixel = image.getPixel(x, y);
          int r = img.getRed(pixel) + noise;
          int g = img.getGreen(pixel) + noise;
          int b = img.getBlue(pixel) + noise;
          image.setPixelRgba(x, y, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255), 255);
        }
      }
    }

    setState(() {
      _noisyImage = Uint8List.fromList(img.encodePng(image));
    });
  }

  // 사진 다운로드 
  Future<void> _saveImage() async {
    if (_noisyImage == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/edited_image.png';
    final imageFile = File(imagePath);

    await imageFile.writeAsBytes(_noisyImage!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("이미지가 저장되었습니다: $imagePath")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("노이즈 추가"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 이미지 표시 영역
            GestureDetector(
              onTap: _pickImage,
              child: _image == null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Center(
                        child: Text(
                          "이미지를 선택해주세요",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    )
                  : Image.memory(
                      _noisyImage ?? _image!.readAsBytesSync(),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),

            // 슬라이더 (노이즈 조절)
            Slider(
              value: _noiseLevel,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  _noiseLevel = value;
                });
                _applyNoise(); // 노이즈 
              },
            ),

            // 사진 다운로드 버튼
            ElevatedButton(
              onPressed: _saveImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text(
                "사진 다운로드",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

     



