class Noise{
  final String file;

  Noise({
    required this.file
  });

  factory Noise.fromJson(Map<String, dynamic> json) {
    return Noise(
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'file': file
    };
    return data;
  }
}