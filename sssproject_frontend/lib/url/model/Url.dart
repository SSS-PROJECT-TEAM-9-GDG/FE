class Url{
  final String url;
  final int maliciousCount;
  final bool malicious;

  Url({
    required this.url,
    required this.maliciousCount,
    required this.malicious
  });

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      url: json['url'],
      malicious: json['malicious'],
      maliciousCount: json['maliciousCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'url': url,
      'malicious': malicious,
      'maliciousCount': maliciousCount
    };
    return data;
  }
}