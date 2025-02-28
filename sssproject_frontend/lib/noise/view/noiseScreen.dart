import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'package:sssproject_frontend/const/colors.dart';
import 'package:sssproject_frontend/const/noiseLevel.dart';
import 'package:sssproject_frontend/const/textstyle.dart';

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
  bool isProcessing = false;

  Future<void> _pickImage() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _noisyImage = null;
          _noiseLevel = 0.0;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("저장소 접근 권한이 필요합니다.")),
      );
    }
  }

    // 편집된 이미지 저장
  Future<void> _saveImage() async {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("이미지가 저장되었습니다")),
    );
  }

  Future<Uint8List> _applyNoiseInBackground(Uint8List imageBytes, double noiseLevel) async {
    return await compute(_addNoise, {'imageBytes': imageBytes, 'noiseLevel': noiseLevel});
  }

  static Uint8List _addNoise(Map<String, dynamic> params) {
    final imageBytes = params['imageBytes'] as Uint8List;
    final noiseLevel = params['noiseLevel'] as double;
    final image = img.decodeImage(imageBytes);
    if (image == null) return imageBytes;
    
    final noiseAmount = (noiseLevel * 255).toInt();
    final random = Random();
    
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        if (random.nextDouble() < noiseLevel) {
          var pixel = image.getPixel(x, y);
          num r = (pixel.r + random.nextInt(noiseAmount) - noiseAmount ~/ 2).clamp(0, 255);
          num g = (pixel.g + random.nextInt(noiseAmount) - noiseAmount ~/ 2).clamp(0, 255);
          num b = (pixel.b + random.nextInt(noiseAmount) - noiseAmount ~/ 2).clamp(0, 255);
          image.setPixelRgba(x, y, r, g, b, 255);
        }
      }
    }
    return Uint8List.fromList(img.encodePng(image));
  }

  Future<void> _applyNoise() async {
    if (_image == null) return;

    setState(() {
      isProcessing = true;
    });

    Uint8List imageBytes = await _image!.readAsBytes();
    Uint8List processedImage = await _applyNoiseInBackground(imageBytes, _noiseLevel);

    setState(() {
      _noisyImage = processedImage;
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryBlue.withOpacity(0.5),
      appBar: AppBar(
        title: const Text("노이즈 추가"),
        centerTitle: true,
        backgroundColor: backgroundWhite,
        foregroundColor: textBlack,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _image == null
                  ? Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: borderGrey),
                      ),
                      child: const Center(
                        child: Text(
                          "이미지를 선택해주세요",
                          style: imageHintStyle,
                        ),
                      ),
                    )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '다른 이미지를 불러오려면 이미지를 탭해주세요.',
                          style: imageHintStyle2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        isProcessing
                            ? const CircularProgressIndicator()
                            : Image.memory(
                                _noisyImage ?? _image!.readAsBytesSync(),
                                width: size.width * 0.85,
                                height: size.width * 0.85,
                                fit: BoxFit.contain,
                              ),
                      ],
                    ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorColor: secondaryBlue,
                valueIndicatorTextStyle: buttonStyle,
                trackHeight: 15.0,
                thumbColor: Colors.white,
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white54,
              ),
            child: Slider(
              value: _noiseLevel,
              label: noiseLevel[_noiseLevel],
              min: 0.0,
              max: 1.0,
              divisions: 3,
              onChanged: _image == null
                  ? null
                  : (value) {
                      setState(() {
                        _noiseLevel = value;
                      });
                      _applyNoise();
                    },
            ),
            ),
              ElevatedButton(
              onPressed: _noisyImage == null ? null : _saveImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text(
                "사진 다운로드",
                style: buttonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sssproject_frontend/const/colors.dart';
// import 'package:sssproject_frontend/const/noiseLevel.dart';
// import 'package:sssproject_frontend/const/textstyle.dart';
// import 'package:sssproject_frontend/noise/repository/noiseService.dart';

// class NoiseEditorScreen extends StatefulWidget {
//   const NoiseEditorScreen({super.key});

//   @override
//   _NoiseEditorScreenState createState() => _NoiseEditorScreenState();
// }

// class _NoiseEditorScreenState extends State<NoiseEditorScreen> {
//   XFile? _image;
//   double _noiseLevel = 0.0;
//   Uint8List? _noisyImage;
//   final ImagePicker _picker = ImagePicker();
//   NoiseService noiseService = NoiseService();

//   // 이미지 선택 및 권한 요청 (갤러리)
//   Future<void> _pickImage() async {
//     PermissionStatus status = await Permission.storage.request();
//     if (status.isGranted) {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _image = pickedFile;
//           _noisyImage = null;
//           _noiseLevel = 0.0; // 초기화
//         });
//       }
//     } else {
//       print("권한 거부됨: $status");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("저장소 접근 권한이 필요합니다.")),
//       );
//     }
//   }

//   // 사진 다운로드
//   Future<void> _saveImage() async {
//     if (_noisyImage == null) return;

//     final directory = await getApplicationDocumentsDirectory();
//     final imagePath = '${directory.path}/edited_image.png';
//     final imageFile = File(imagePath);

//     await imageFile.writeAsBytes(_noisyImage!);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("이미지가 저장되었습니다: $imagePath")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: primaryBlue.withOpacity(0.5),
//       appBar: AppBar(
//         title: const Text("노이즈 추가"),
//         centerTitle: true,
//         backgroundColor: backgroundWhite,
//         foregroundColor: textBlack,
//         elevation: 1,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             // 이미지 표시 영역
//             GestureDetector(
//               onTap: _pickImage,
//               child: _image == null
//                   ? Container(
//                       height: size.height * 0.4,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: backgroundWhite,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: borderGrey),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "이미지를 선택해주세요",
//                           style: imageHintStyle,
//                         ),
//                       ),
//                     )
//                   : FutureBuilder<Uint8List>(
//                       future: _image!.readAsBytes(), // 비동기 처리
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const CircularProgressIndicator(); // 로딩 표시
//                         } else if (snapshot.hasError || !snapshot.hasData) {
//                           return const Text("이미지를 불러올 수 없습니다.");
//                         } else {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text('다른 이미지를 불러오려면 이미지를 탭해주세요.', style: imageHintStyle2, textAlign: TextAlign.center,),
//                               const SizedBox(height: 30,),
//                               Image.memory(
//                                 _noisyImage ?? snapshot.data!,
//                                 width: size.width*0.7,
//                                 height: size.width*0.7,  // 화면에 맞게 조정
//                                 fit: BoxFit.contain,
//                               ),

//                             ],
//                           );
//                         }
//                       },
//                     ),
//             ),
//             // 슬라이더 (노이즈 조절)
//             SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                 valueIndicatorColor: secondaryBlue,
//                 valueIndicatorTextStyle: buttonStyle,
//                 trackHeight: 8.0, // 트랙(슬라이더 선)의 두께 설정 (기본값: 4.0)
//                 thumbColor: Colors.white, // 핸들 색상
//                 activeTrackColor: Colors.white, // 활성 트랙 색상
//                 inactiveTrackColor: Colors.white54, // 비활성 트랙 색상
//               ),
//               child: Slider(
//               value: _noiseLevel,
//               label: noiseLevel[_noiseLevel],
//               min: 0.0,
//               max: 1.0,
//               divisions: 2,
//               onChanged: (value) {
//                 setState(() { 
//                   _noiseLevel = value; // UI 업데이트
//                 });
//                 noiseService.getNoiseData(noiseLevel[value]!, _image!);
//               },
//             ),
//             ),

//             // 사진 다운로드 버튼
//             ElevatedButton(
//               onPressed: _saveImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: secondaryBlue,
//                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
//               ),
//               child: const Text(
//                 "사진 다운로드",
//                 style: buttonStyle,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
