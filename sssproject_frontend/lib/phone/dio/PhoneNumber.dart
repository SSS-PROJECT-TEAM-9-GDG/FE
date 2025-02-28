class PhoneNumber {
  final String spam;
  final int spamCount;
  final String cyberCrime;

  PhoneNumber({
    required this.spam,
    required this.spamCount,
    required this.cyberCrime,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      spam: json['spam'],
      spamCount: json['spam_count'],
      cyberCrime: json['cyber_crime']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'spam': spam,
      'spam_count': spamCount,
      'cyber_crime': cyberCrime
    };
    return data;
  }
}